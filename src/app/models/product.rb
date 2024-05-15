class Product < ApplicationRecord
  enum :status, { draft: 0, published: 1, archived: 2, trashed: 3 }

  with_options presence: true do
    validates :name
    validates :price, numericality: { only_integer: true }
    validates :description
  end

  has_many :wish_products
end
