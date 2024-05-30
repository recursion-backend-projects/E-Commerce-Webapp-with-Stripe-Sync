class DownloadProduct < ApplicationRecord
    belongs_to :customer
    belongs_to :product

    #validates :customer_id, uniqueness: { scope: :product_id, message: 'この商品はすでにお気に入りリストに追加されています。' }
  end