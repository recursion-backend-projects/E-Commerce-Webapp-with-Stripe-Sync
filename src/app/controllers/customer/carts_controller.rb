class Customer::CartsController < ApplicationController
  before_action :set_product, only: %i[create update destroy]
  before_action :validate_quantity, only: %i[create update]
  after_action :update_cart_items_count, only: %i[create update destroy]

  # カートの内容を表示するアクション
  def show
    @customer = true
    @cart = current_cart
    @cart_items = []
    @average_ratings = {}
    @total = 0
    @is_proceed_register = true
    return if @cart.empty?

    set_show_info
  end

  # カートに商品を追加するアクション
  def create
    quantity = params[:product][:quantity].to_i

    if quantity > @product.remaining_stock
      redirect_back fallback_location: root_path, alert: '在庫数を超える数量はカートに追加できません'
    else
      flash[:notice] = 'カートに追加しました'
      add_or_update @product.id.to_s, quantity
    end
  end

  # カート内の商品の数量を更新するアクション
  def update
    quantity = params[:product][:quantity].to_i
    session[:cart][@product.id.to_s] = quantity
    redirect_to cart_path
  end

  # カートから商品を削除するアクション
  def destroy
    session[:cart].delete(@product.id.to_s)
    redirect_to cart_path
  end

  private

  # 商品を設定するメソッド
  def set_product
    @product = Product.find(params[:product][:id].to_i)
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = '商品が見つかりません'
    redirect_to cart_path
  end

  # 数量を検証するメソッド
  def validate_quantity
    quantity = params[:product][:quantity].to_i
    return unless quantity <= 0

    redirect_back fallback_location: root_path, alert: '数量は1以上でなければなりません'
  end

  # カートに商品を追加または更新するメソッド
  def add_or_update(product_id, quantity)
    session[:cart] ||= {}
    if session[:cart].key?(product_id)
      session[:cart][product_id] += quantity
    else
      session[:cart][product_id] = quantity
    end
    redirect_back fallback_location: root_path
  end

  def update_cart_items_count
    counter = 0
    @current_cart.each_value do |value|
      counter += value
    end

    session[:cart_items_count] = counter
  end

  # showに関わる情報を設定するメソッド
  def set_show_info
    @cart.each_key do |product_id|
      product = Product.find_by(id: product_id.to_i)
      if product.nil? || product.stock <= 0
        session[:cart].delete(product_id.to_s)
        flash.now[:alert] = 'カート内の商品が削除されました'
        update_cart_items_count
      else
        @total += product.price * session[:cart][product_id]
        @cart_items.push(product)
        @average_ratings[product_id.to_i] = product.product_reviews.average(:rating).to_i
        @is_proceed_register = false if product.status != 'published'
      end
    end
  end
end
