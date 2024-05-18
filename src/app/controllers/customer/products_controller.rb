class Customer::ProductsController < ApplicationController
    def show
      @customer = true
      @product = Product.find(params[:id])
    end
end