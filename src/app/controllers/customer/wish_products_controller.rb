class Customer::WishProductsController < ApplicationController
    before_action :authenticate_customer_account!
    before_action :set_customer
    before_action :set_is_my_wishlist, only: [:index]

    def index
      @wish_products = @customer.wish_products
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

    private

    def set_customer
      customer_account = CustomerAccount.find(params[:customer_account_id])
      @customer = customer_account.customer
    end

    def set_is_my_wishlist
      @is_my_wishlist = current_customer_account.customer == @customer
    end
  end
