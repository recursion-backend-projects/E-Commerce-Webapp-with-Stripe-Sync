class Customer::DownloadProductsController < ApplicationController
    before_action :authenticate_customer_account!

    def index
      @customer = true
    end
end