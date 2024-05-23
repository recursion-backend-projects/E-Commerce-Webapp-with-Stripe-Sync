class Customer::ProductsController < ApplicationController
  def index
    @customer = true
    # TODO: 必要な情報の取得
  end

  def show
    @customer = true
    @product = Product.find(params[:id])
    @product_count_in_cart = @current_cart&.dig(@product.id.to_s) || 0
    @remaining_stock = @product.stock - @product_count_in_cart
  end
end
