class Customer::WishProductsController < ApplicationController
  before_action :authenticate_customer_account!, only: %i[index create destroy]
  before_action :set_customer, only: %i[index create destroy]
  before_action :set_is_my_wishlist, only: [:index]

  def index
    @wish_products = @customer.wish_products.page(params[:page])
    wish_product_token = if WishProductToken.exists?(customer_id: @customer.id)
                           WishProductToken.find_by(customer_id: @customer.id).token
                         else
                           WishProduct.create(
                             token: WishProductToken.generate_token, customer_id: @customer.id
                           )
                         end
    @sharelink = "#{request.base_url}/wish_products/share/#{wish_product_token}"
    @average_ratings = get_average_ratings(@wish_products)
  end

  def create
    product = Product.find(params[:product_id])
    @wish_product = WishProduct.create(customer_id: @customer.id, product_id: product.id)
    redirect_to product_path(product.id)
  rescue StandardError => e
    Rails.logger.error "Error creating wish product: #{e.message}"
    redirect_to product_path(product.id)
  end

  def destroy
    @wish_product = WishProduct.find(params[:id])
    @wish_product.delete if @wish_product.customer.customer_account == current_customer_account

    redirect_to customer_account_wish_products_path(current_customer_account)
  end

  def share
    @customer = true
    token = params[:token]

    if WishProductToken.exists?(token:)
      customer_id = WishProductToken.find_by(token:).customer_id
      @customer_account = CustomerAccount.find_by(customer_id:)
      @wish_products = Customer.find(customer_id).wish_products.page(params[:page])
      @average_ratings = get_average_ratings(@wish_products)
    else
      redirect_to root_path
      flash[:alert] = '無効なページです'
    end
  end

  private

  def set_customer
    customer_account = CustomerAccount.find(params[:customer_account_id])
    @customer = customer_account.customer
  end

  def set_is_my_wishlist
    @is_my_wishlist = current_customer_account.customer == @customer
  end

  def get_average_ratings(wish_products)
    average_ratings = {}

    wish_products.each do |wish_product|
      average_ratings[wish_product.product.id] = wish_product.product.product_reviews.average(:rating).to_i
    end

    average_ratings
  end
end
