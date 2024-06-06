class Product < ApplicationRecord
  acts_as_taggable_on :tags

  belongs_to :product_category
  enum :status, { draft: 0, published: 1, archived: 2 }
  enum :product_type, { digital: 0, physics: 1 }

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }
    validates :description
  end

  # 商品画像バリデーション
  validates :images, attached: false, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
                     size: { less_than: 3.megabytes }

  # ダウンロード用zipバリデーション
  validates :digital_file, attached: false, content_type: ['application/zip'],
                           size: { less_than: 20.megabytes }

  has_many :wish_products, dependent: :destroy
  has_many :favorite_products, dependent: :destroy
  has_many :customers, through: :wish_products
  has_many :product_reviews, dependent: :destroy
  has_many_attached :images
  has_one_attached :digital_file
  has_one :order_item, dependent: :destroy

end
