class Customer::OrdersController < ApplicationController
  before_action :authenticate_customer_account!
  def index
    @customer = true
    @orders = current_customer.orders.order(order_date: :desc)
  end
end
