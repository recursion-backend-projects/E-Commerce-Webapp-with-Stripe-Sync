class Webhooks::StripesController < ApplicationController
  # handler関数ではCSRFトークンの検証をスキップする
  protect_from_forgery except: :create

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV.fetch("STRIPE_ENDPOINT_SECRET_#{Rails.env.upcase}")

    event = construct_stripe_event(payload, sig_header, endpoint_secret)
    return head :bad_request unless event

    event_hundler event
    head :ok
  end

  private

  def event_hundler(event)
    # イベントのハンドリング
    case event.type
    when 'product.created'
      create_product(event)

    when 'product.updated'
      update_product(event)

    when 'product.deleted'
      delete_product(event.data.object.id)

    # 決済が完了した後に実行したい関数をここに追加していく
    when 'checkout.session.completed'
      session = event.data.object
      create_order session
    else
      logger.debug("Unhandled event type: #{event.type}")
    end
  end

  def construct_stripe_event(payload, sig_header, endpoint_secret)
    Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
  rescue JSON::ParserError, Stripe::SignatureVerificationError => e
    # 無効なペイロード
    logger.error(e)
    false
  end

  def create_product(event)
    stripe_product = event.data.object
    # product.updatedイベント発火のタイミングで金額は設定する
    Product.create(name: stripe_product.name, stripe_product_id: stripe_product.id)
  end

  def update_product(event)
    stripe_product = event.data.object

    # 価格がnilの場合はそのままreturn
    return unless stripe_product.default_price

    product = Product.find_by(stripe_product_id: stripe_product.id)
    return unless product

    stripe_price = Stripe::Price.retrieve(stripe_product.default_price)

    if Product.stripe_price_invalid?(stripe_price)
      old_price = stripe_price
      # 条件を満たした新しいStripe Priceを作成する
      stripe_price = Stripe::Price.create({ currency: 'jpy', unit_amount: old_price.unit_amount,
                                            product: old_price.product })
      # 新しいStripe Priceを適用する
      Stripe::Product.update(old_price.product, {
                               default_price: stripe_price.id
                             })
      # 条件を満たしていないStripe Priceをアーカイブにする
      Stripe::Price.update(old_price.id, { active: false })
    end

    product.update(name: stripe_product.name, price: stripe_price.unit_amount, stripe_price_id: stripe_price.id)

    # product削除時に、product.updatedが発火してエラーが出るのでキャッチする
  rescue Stripe::InvalidRequestError => e
    logger.error(e)
  end

  def delete_product(product_id)
    product = Product.find_by(stripe_product_id: product_id)
    product.destroy
  end

  def create_order(session)
    session_object = Stripe::Checkout::Session.retrieve({ expand: ['line_items'], id: session.id })
    line_items = session_object.line_items
    payment_intent = Stripe::PaymentIntent.retrieve(session.payment_intent)
    charge = Stripe::Charge.retrieve(payment_intent.latest_charge)
    receipt_url = charge.receipt_url

    is_guest_order = session_object.client_reference_id.nil?
    customer = is_guest_order ? nil : Customer.find_by(id: session_object.client_reference_id.to_i)

    order = Order.create(
      order_number: Order.generate_order_number,
      total: session.amount_total,
      order_date: Time.current,
      guest_email: is_guest_order ? session_object.customer_details.email : nil,
      customer:,
      receipt_url:
    )

    create_order_items(line_items, order)
    create_shipping(order)
    download_urls = create_download_products(line_items, order)

    email = is_guest_order ? order.guest_email : order.customer.customer_account.email
    NotificationMailer.with(email:, order:, download_urls:).order_complete_email.deliver_later
  end

  def create_order_items(line_items, order)
    line_items.data.each do |line_item|
      product = Product.find_by(stripe_product_id: line_item.price.product)

      # 在庫数を減らす
      product.update(stock: product.stock - line_item.quantity)

      OrderItem.create(
        quantity: line_item.quantity,
        order:,
        product:
      )
    end
  end

  def create_download_products(line_items, order)
    digital_status = 'digital'
    download_urls = []

    line_items.data.each do |line_item|
      product = Product.find_by(stripe_product_id: line_item.price.product)
      next unless product.product_type == digital_status

      if order.customer_id
        download_product = find_or_create_download_product(order.customer_id, product.id)
        log_download_product_action(download_product, order.customer_id, product.id)
      else
        download_product = generate_guest_download_product(product)
      end

      download_urls << generate_download_url(download_product)
    end

    download_urls
  end

  def find_or_create_download_product(customer_id, product_id)
    download_product = DownloadProduct.find_or_initialize_by(
      customer_id:,
      product_id:
    )

    download_product.save if download_product.new_record?
    download_product.generate_download_url unless download_product.new_record?

    download_product
  end

  def generate_guest_download_product(product)
    DownloadProduct.new(
      customer_id: nil,
      product_id: product.id,
      download_url: generate_temporary_download_url(product)
    )
  end

  def generate_temporary_download_url(product)
    Rails.application.routes.url_helpers.rails_blob_path(
      product.digital_file,
      only_path: false,
      disposition: 'attachment'
    )
  end

  def log_download_product_action(download_product, customer_id, product_id)
    action = download_product.new_record? ? '新規作成しました' : '更新しました'
    Rails.logger.debug { "DownloadProductを#{action} - customer_id: #{customer_id}, product_id: #{product_id}" }
  end

  def generate_download_url(download_product)
    host = Rails.application.config.action_mailer.default_url_options[:host]
    protocol = Rails.application.config.action_mailer.default_url_options[:protocol] || 'http'
    "#{protocol}://#{host}#{download_product.download_url}"
  end

  def create_shipping(order)
    return unless order.order_items.any? { |order_item| order_item.product.physics? }

    Shipping.create(order:)
  end
end
