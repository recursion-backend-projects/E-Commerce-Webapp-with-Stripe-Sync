class WishProductsController < ApplicationController
    before_action :authenticate_customer_account!

    def index

    end
end
