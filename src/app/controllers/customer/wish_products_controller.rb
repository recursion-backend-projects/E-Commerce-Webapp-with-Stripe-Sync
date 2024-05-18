class Customer::WishProductsController < ApplicationController
    before_action :authenticate_customer_account!

    def index
        @customer_account = CustomerAccount.find_by(id: params[:customer_account_id])
        @wish_products = @customer_account.wish_products.includes(:product)
    end
end
