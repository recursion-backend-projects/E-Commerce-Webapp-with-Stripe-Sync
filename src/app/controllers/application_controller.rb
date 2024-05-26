class ApplicationController < ActionController::Base
  before_action :current_cart
  before_action :cart_items_count
  before_action :current_customer, if: :customer_account_signed_in?

  private

  # 現在のカートを取得するメソッド
  def current_cart
    # @current_cartが未定義またはnilの場合、session[:cart]を使用し、それも未定義またはnilの場合は空のハッシュを設定する
    @current_cart ||= session[:cart] ||= {}
  end

  def cart_items_count
    @cart_items_count = session[:cart_items_count] ||= @current_cart.values.sum
  end

  def reset_cart
    session[:cart] = {}
    session[:cart_items_count] = 0
    @cart_items_count = session[:cart_items_count]
    @current_cart = session[:cart]
  end

  def current_customer
    @current_customer ||= Customer.find_by(id: current_customer_account&.customer_id)
  end
end
