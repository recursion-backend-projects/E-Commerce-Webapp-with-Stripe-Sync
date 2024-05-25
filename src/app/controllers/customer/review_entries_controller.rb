class Customer::ReviewEntriesController < ApplicationController

    def show
        @customer = true
        @product = Product.find(params[:id])
    end
end
