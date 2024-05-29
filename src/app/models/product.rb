class Product < ApplicationRecord
  belongs_to :product_category
  enum :status, { draft: 0, published: 1, archived: 2 }

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }
    validates :description
  end

  validates :images, attached: false, content_type: ['image/png', 'image/jpeg', 'image/jpg'],
                     size: { less_than: 3.megabytes }

  has_many :wish_products, dependent: :destroy
  has_many :favorite_products, dependent: :destroy
  has_many :customers, through: :wish_products
  has_many_attached :images
end
