class Customer::ProductsController < ApplicationController
  def show
    @customer = true
    @product = Product.find(params[:id])
    @product_reviews = @product.product_reviews.order(created_at: :desc).includes(customer: :customer_account).limit(5)
    @average_rating = @product.product_reviews.average(:rating).to_i
    @product_count_in_cart = @current_cart&.dig(@product.id.to_s) || 0
    @remaining_stock = @product.stock - @product_count_in_cart
  end
end
