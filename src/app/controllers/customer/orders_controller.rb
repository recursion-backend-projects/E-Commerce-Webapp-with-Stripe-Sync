class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer_account!
  def index
    @customer = true
    @orders = current_customer.orders.order(order_date: :desc).page(params[:page])
    @product_reviews = @orders.each_with_object({}) do |order, hash|
      order.order_items.each do |order_item|
        product = order_item.product
        review = ProductReview.find_by(product:, customer: current_customer_account)
        hash[product.id] = review if review
      end
    end
  end
end
