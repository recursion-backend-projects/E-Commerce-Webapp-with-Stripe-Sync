class Product < ApplicationRecord
  belongs_to :product_category
  enum :status, { draft: 0, published: 1, archived: 2 }

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }
    validates :description
  end

  has_many :wish_products
  has_many :customers, through: :wish_products
end
