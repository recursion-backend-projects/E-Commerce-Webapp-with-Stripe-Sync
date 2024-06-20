class Customer::DownloadProductsController < ApplicationController
  before_action :authenticate_customer_account!

  def index
    @customer = true
    @download_products = current_customer.download_products.order(updated_at: :desc).page(params[:page])
    @average_ratings = {}

    @download_products.each do |download_product|
      @average_ratings[download_product.product.id] = download_product.product.product_reviews.average(:rating).to_i
    end
  end
end
