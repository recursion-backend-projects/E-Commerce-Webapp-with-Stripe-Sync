class Customer::CartsController < ApplicationController
  def show
    @customer = true
    @cart = session[:cart] || {}
    @cart_items = []
    return if @cart.empty?

    @cart.each_key do |product_id|
      @cart_items.push(Product.find(product_id))
    end
  end

  def create
    product_id = params[:product_id]
    @product = Product.find(product_id.to_i)
    quantity = params[:quantity].to_i
    session[:cart] ||= {}
    @product_count_in_cart = session[:cart]&.dig(product_id) || 0
    @remaining_stock = @product.stock - @product_count_in_cart

    if quantity > @remaining_stock
      flash[:alert] = '在庫数を超える数量はカートに追加できません'
      redirect_to @product
    else
      flash[:notice] = 'カートに追加しました'
      add_or_update product_id, quantity
    end
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

  private

  def add_or_update(product_id, quantity)
    if session[:cart].key?(product_id)
      session[:cart][product_id] += quantity
    else
      session[:cart][product_id] = quantity
    end
    redirect_to cart_path
  end
end
