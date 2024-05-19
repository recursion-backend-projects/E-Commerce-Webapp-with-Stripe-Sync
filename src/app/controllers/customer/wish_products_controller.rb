class Customer::WishProductsController < ApplicationController
    before_action :authenticate_customer_account!, :set_customer_account
    before_action :set_is_my_wishlist, only: [:index]

    def index
        @customer = true
        @wish_products = @customer_account.wish_products.includes(:product)
    end

    def create
        begin
            customer = @customer_account.customers.first
            product = Product.find(params[:product_id])
            @wish_product = WishProduct.create(customer_id: customer.id, product_id: product.id)
            redirect_to product_path(product.id)
        rescue => e
            Rails.logger.error "Error creating wish product: #{e.message}"
            redirect_to product_path(product.id)
        end
    end

    def destroy
        @wish_product = WishProduct.find(params[:id])
        if @wish_product.customer.customer_account == current_customer_account
            @wish_product.delete
        end

        redirect_to customer_account_wish_products_path(@customer_account)
    end

    def set_customer_account
        @customer_account = CustomerAccount.find_by(id: params[:customer_account_id])
    end

    def set_is_my_wishlist
        @is_my_wishlist = current_customer_account == @customer_account
    end
end
