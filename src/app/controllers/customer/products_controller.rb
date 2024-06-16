class Customer::ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def show
    @customer = true
    @product_reviews = @product.product_reviews.order(created_at: :desc).includes(customer: :customer_account).limit(5)
    @average_rating = @product.product_reviews.average(:rating).to_i
    @remaining_stock = @product.remaining_stock
  end

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '商品が見つかりません'
    redirect_to root_path
  end
end
