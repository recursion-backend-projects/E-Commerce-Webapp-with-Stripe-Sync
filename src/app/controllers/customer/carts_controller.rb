class Customer::CartsController < ApplicationController
  def show
    @cart = session[:cart] || Cart.new
  end

  def create
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    cart = session[:cart] ||= Cart.new
    cart.add_item(product_id, quantity)
    session[:cart] = cart
    redirect_to cart_path
  end
end
