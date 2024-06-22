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
    Product.create(name: stripe_product.name)
  end

  def update_product(event)
    stripe_product = event.data.object

    # 価格がnilの場合はそのままreturn
    return unless stripe_product.default_price

    product = Product.find_by(stripe_product_id: stripe_product.id)
    return unless product

    stripe_price = Stripe::Price.retrieve(stripe_product.default_price)

    if stripe_price_invalid?(stripe_price)
      stripe_price = Stripe::Price.create({ currency: 'jpy', unit_amount: stripe_price.unit_amount,
                                            product: stripe_product.id })
    end

    product.update(name: stripe_product.name, price: stripe_price.unit_amount, stripe_price_id: stripe_price.id)

    # product削除時に、product.updatedが発火してエラーが出るのでキャッチする
  rescue Stripe::InvalidRequestError => e
    logger.error(e)
  end

  ##
  # 受け取ったStripe Price Objectが以下のいずれかの条件を満たしていない場合はtrueを返す
  # 条件1: 1回限り (type: one_time)
  # 条件2: 定額 (billing_scheme: per_unit)
  # 条件3: 日本円 (currency: jpy)
  ##
  def stripe_price_invalid?(stripe_price)
    stripe_price.billing_scheme != 'per_unit' || stripe_price.type != 'one_time' || stripe_price.currency != 'jpy'
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
      order_number: generate_order_number,
      total: session.amount_total,
      order_date: Time.current,
      guest_email: is_guest_order ? session_object.customer_details.email : nil,
      customer:,
      receipt_url:
    )

    create_order_items(line_items, order)
    create_shipping(order)
    create_download_products(line_items, order)
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
    unless order.customer_id
      Rails.logger.debug { "注文 #{order.id} に customer_id が見つかりませんでした" }
      return
    end

    digital_status = 'digital'

    line_items.data.each do |line_item|
      product = Product.find_by(stripe_product_id: line_item.price.product)

      # 商品がデジタル商品でない場合は登録せず次のループに飛ばす
      next unless product.product_type == digital_status

      # 既に同じ顧客と商品の組み合わせが存在する場合は更新
      download_product = DownloadProduct.find_or_initialize_by(
        customer_id: order.customer_id,
        product_id: product.id
      )

      if download_product.new_record?
        download_product.save
        Rails.logger.debug { "DownloadProductを新規作成しました - customer_id: #{order.customer_id}, product_id: #{product.id}" }
      else
        download_product.generate_download_url
        Rails.logger.debug { "DownloadProductを更新しました - customer_id: #{order.customer_id}, product_id: #{product.id}" }
      end
    end
  end

  def generate_order_number
    loop do
      new_order_number = "#{generate_random_digit(3)}-#{generate_random_digit(7)}-#{generate_random_digit(7)}"

      return new_order_number unless Order.exists?(order_number: new_order_number)
    end
  end

  def generate_random_digit(digit)
    Array.new(digit) { rand(9) }.join
  end

  def create_shipping(order)
    return unless order.order_items.any? { |order_item| order_item.product.physics? }

    Shipping.create(order:)
  end
end
