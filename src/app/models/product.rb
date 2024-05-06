class Product < ApplicationRecord

  with_options presence: true do
    validates :name
    validates :price
    validates :stock
    validates :description
  end
end
