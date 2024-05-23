class WishProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :customer_id, uniqueness: { scope: :product_id, message: 'この商品はすでにウィッシュリストに追加されています。' }
end
