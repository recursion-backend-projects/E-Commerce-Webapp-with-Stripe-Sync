class Customer::CartsController < ApplicationController
  def show
    @customer = true
    @cart = session[:cart] || {}
    p @cart
    @cart_items = []
    return if @cart.empty?

    @cart.each_key do |product_id|
      @cart_items.push(Product.find(product_id))
    end
  end

  def add
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    session[:cart] ||= {}
    if session[:cart].key?(product_id)
      session[:cart][product_id] += quantity
    else
      session[:cart][product_id] = quantity
    end
    redirect_to cart_path
  end

  def update
    product_id = params[:product_id]
    quantity = params[:quantity].to_i
    session[:cart][product_id] = quantity
  end

  def destroy
    product_id = params[:product_id]
    session[:cart][product_id]
    session[:cart].delete(product_id)

    redirect_to cart_path
  end
end
