class Customer::OrdersController < ApplicationController
  def index
    @customer = true
    @orders = current_customer.orders
  end
end
