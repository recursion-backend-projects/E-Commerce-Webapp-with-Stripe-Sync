class Customer::ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def show
    @customer = true
    @product_reviews = @product.product_reviews.order(created_at: :desc).includes(customer: :customer_account).limit(5)
    @average_rating = @product.product_reviews.average(:rating).to_i
    @product_count_in_cart = @current_cart&.dig(@product.id.to_s) || 0
    @remaining_stock = @product.stock - @product_count_in_cart
  end

  def set_product
    @product = Product.find_by(id: params[:id], status: 'published')
    if @product.nil?
      flash[:alert] = '商品が見つかりません'
      redirect_to root_path
    end
  end
end
