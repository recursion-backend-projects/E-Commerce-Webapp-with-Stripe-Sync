class Customer::CheckoutsController < ApplicationController
  def create
    # 「ご購入手続きへ」からの購入の場合
    if params[:checkout_action]
      product_id = params[:product_id]
      quantity = params[:quantity].to_i
      line_items = generate_line_items({ product_id => quantity })
      success_url = generate_success_url('direct')

    # 「レジに進む」からの購入の場合
    elsif params[:register_action]
      line_items = generate_line_items(current_cart)
      success_url = generate_success_url('register')
    else
      redirect_back fallback_location: root_path, alert: '不明なアクションです'
    end

    customer = current_customer
    session = create_checkout_session(customer, line_items, success_url)
    redirect_to session.url, status: :see_other, allow_other_host: true
  end

  # 支払いが成功した時に表示するページを表示するアクション
  def success
    @customer = true

    # 有効なsession_idのクエリじゃない場合はアラートを出す
    begin
      Stripe::Checkout::Session.retrieve(params[:session_id])

      # 「レジに進む」からの購入の場合のみ、カートをリセットする
      if params[:checkout_type] == 'register'
        # 決済が完了したのでカートをリセットする
        reset_cart
      end
    rescue Stripe::InvalidRequestError => e
      logger.error(e)
      redirect_to root_path
      flash[:alert] = '無効なページです'
    end
  end

  private

  def generate_line_items(product_id_quantity_pair)
    line_items = []
    product_id_quantity_pair.each do |product_id, quantity|
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

  def generate_success_url(checkout_type)
    if Rails.env.production?
      scheme = 'https'
      host = request.domain
      domain = "#{scheme}://#{host}"
    else
      domain = 'http://localhost:3000'
    end

    "#{domain}/checkout/success?session_id={CHECKOUT_SESSION_ID}&checkout_type=#{checkout_type}"
  end

  def create_checkout_session(customer, line_items, success_url)
    Stripe::Checkout::Session.create({
                                       client_reference_id: customer.present? ? customer.id : nil,
                                       customer: customer.present? ? customer&.stripe_customer_id : nil,
                                       line_items:,
                                       mode: 'payment',
                                       #  ユーザーがCheckoutで戻るボタンをクリックするとこのページにリダイレクトされるURL
                                       cancel_url: cart_url,
                                       #  決済が完了したときにリダイレクトされるURL
                                       success_url:,
                                       #  TODO:デジタル商品のみの場合はshipping_address_collectionを不要なので削除する
                                       shipping_address_collection: {
                                         allowed_countries: %w[JP]
                                       },
                                       # requiredにしないと、請求先は国だけ選べるという微妙な見た目になってしまう
                                       billing_address_collection: 'required'
                                     })
  end
end
