class ApplicationController < ActionController::Base
  before_action :current_cart
  before_action :cart_items_count

  private

  # 現在のカートを取得するメソッド
  def current_cart
    # @current_cartが未定義またはnilの場合、session[:cart]を使用し、それも未定義またはnilの場合は空のハッシュを設定する
    @current_cart ||= session[:cart] ||= {}
  end

  def cart_items_count
    @cart_items_count = session[:cart_items_count] ||= @current_cart.values.sum
  end
end
