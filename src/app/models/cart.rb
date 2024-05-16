class Cart < ApplicationRecord
  attr_accessor :items

  def initialize
    super
    @items = []
  end

  def add_item(product_id, quantity)
    @items << CartItem.new(product_id, quantity)
  end

  def total_price
    @items.sum(&:subtotal)
  end
end
