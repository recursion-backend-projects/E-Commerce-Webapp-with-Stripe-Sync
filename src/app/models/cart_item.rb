class CartItem < ApplicationRecord
  attr_reader :product_id, :quantity

  def initialize(product_id, quantity)
    super
    @product_id = product_id
    @quantity = quantity
  end

  def subtotal
    # ここで商品の価格と数量を計算して小計を返す
  end
end
