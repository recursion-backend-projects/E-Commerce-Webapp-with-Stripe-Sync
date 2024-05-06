class StripeWebhooksController < ApplicationController
  # handler関数ではCSRFトークンの検証をスキップする
  protect_from_forgery except: :handler

  def handler
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = Rails.application.credentials.dig(:stripe, :endpoint_secret)
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError, Stripe::SignatureVerificationError => e
      # 無効なペイロード
      logger.error(e)
      status 400
      return
    end

    # イベントのハンドリング
    case event.type
    when 'product.created'
      create_product(event.data.object.id)

    when 'price.created'
      update_product_price(event.data.object.id)
    # ...　その他のイベントを以下に追加していく

    else
      logger.debug("Unhandled event type: #{event.type}")
    end
  end

  private

  def create_product(product_id)
    stripe_product = Stripe::Product.retrieve(product_id)
    # product.createdの時はdefault_priceはnilになることがあるので、price: 0を入れておく
    # price.createdイベント発火のタイミングで正しい金額に更新する
    Product.create(name: stripe_product.name, price: 0,
                   description: stripe_product.description, stripe_product_id: product_id)
  end

  def update_product_price(price_id)
    price = Stripe::Price.retrieve(price_id)
    product = Product.find_by(stripe_product_id: price.product)
    return unless product

    product.update(price: price.unit_amount)
  end
end
