class Webhooks::StripesController < ApplicationController
  # handler関数ではCSRFトークンの検証をスキップする
  protect_from_forgery except: :create

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :endpoint_secret)

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
      create_product(event.data.object.id)

    when 'product.updated'
      update_product_price(event.data.object.id)

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

  def create_product(product_id)
    stripe_product = Stripe::Product.retrieve(product_id)
    # product.createdの時はdefault_priceはnilになることがあるので、price: 0を入れておく
    # product.updatedイベント発火のタイミングで正しい金額に更新する
    product_category = ProductCategory.find_by(name: stripe_product.metadata.product_category)
    Product.create(name: stripe_product.name, price: 0,
                   description: stripe_product.description, stripe_product_id: product_id,
                   product_category_id: product_category.id)
  end

  def update_product_price(product_id)
    stripe_product = Stripe::Product.retrieve(product_id)

    # 価格がnilの場合はそのままreturn
    return unless stripe_product.default_price

    stripe_price = Stripe::Price.retrieve(stripe_product.default_price)
    product = Product.find_by(stripe_product_id: product_id)
    return unless product

    product.update(price: stripe_price.unit_amount, stripe_price_id: stripe_price.id)

    # product削除時に、product.updatedが発火してエラーが出るのでキャッチする
  rescue Stripe::InvalidRequestError => e
    logger.error(e)
  end

  def delete_product(product_id)
    product = Product.find_by(stripe_product_id: product_id)
    product.destroy
  end

  def create_order(session)
    session_object = Stripe::Checkout::Session.retrieve({
                                                          expand: ['line_items'],
                                                          id: session.id
                                                        })
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

  def generate_order_number
    loop do
      new_order_number = "#{generate_random_digit(3)}-#{generate_random_digit(7)}-#{generate_random_digit(7)}"

      return new_order_number unless Order.exists?(order_number: new_order_number)
    end
  end

  def generate_random_digit(digit)
    Array.new(digit) { rand(9) }.join
  end
end
