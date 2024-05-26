class Customer::CheckoutsController < ApplicationController
  def create
    line_items = generate_line_items
    customer = current_customer

    session = Stripe::Checkout::Session.create({
                                                 client_reference_id: customer.present? ? customer.id : nil,
                                                 customer: customer.present? ? customer&.stripe_customer_id : nil,
                                                 line_items:,
                                                 mode: 'payment',
                                                 #  ユーザーがCheckoutで戻るボタンをクリックするとこのページにリダイレクトされるURL
                                                 cancel_url: cart_url,
                                                 #  決済が完了したときにリダイレクトされるURL
                                                 success_url: 'http://localhost:3000/checkout/success?session_id={CHECKOUT_SESSION_ID}',
                                                 #  TODO:デジタル商品のみの場合はshipping_address_collectionを不要なので削除する
                                                 shipping_address_collection: {
                                                   allowed_countries: %w[JP]
                                                 },
                                                 billing_address_collection: 'required'
                                               })
    redirect_to session.url, allow_other_host: true
  end

  # 支払いが成功した時に表示するページを表示するアクション
  def success
    @customer = true

    # 有効なsession_idのクエリじゃない場合はアラートを出す
    begin
      Stripe::Checkout::Session.retrieve(params[:session_id])
      # 決済が完了したのでカートをリセットする
      reset_cart
    rescue Stripe::InvalidRequestError => e
      logger.error(e)
      # TODO: root_pathに変更する
      redirect_to cart_path
      flash[:alert] = '無効なページです'
    end
  end

  private

  def generate_line_items
    line_items = []
    cart = current_cart
    cart.each do |product_id, quantity|
      product = Product.find_by(id: product_id.to_i)

      next unless product

      line_item = {
        price: product.stripe_price_id,
        quantity:
      }

      line_items << line_item
    end

    line_items
  end
end
