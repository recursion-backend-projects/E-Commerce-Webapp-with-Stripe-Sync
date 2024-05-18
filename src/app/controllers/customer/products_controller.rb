class Customer::ProductsController < ApplicationController
  def show
    @customer = true
    @product = Product.find(params[:id])
    @cart = session[:cart] || {}
    @product_count_in_cart = @cart&.dig(@product.id.to_s) || 0
    @remaining_stock = @product.stock - @product_count_in_cart
  end
end
