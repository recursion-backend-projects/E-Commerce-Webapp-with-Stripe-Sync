class Customer::DownloadProductsController < ApplicationController
  before_action :authenticate_customer_account!

  def index
    @customer = true
    @download_products = current_customer.download_products.order(updated_at: :desc)
  end
end
