class Customer::ReviewEntriesController < ApplicationController
    before_action :authenticate_customer_account!

    def edit
        @customer = true
        @product = Product.find(params[:id])
    end
end
