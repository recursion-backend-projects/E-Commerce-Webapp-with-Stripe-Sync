class Product < ApplicationRecord
  with_options presence: true
  validates :name
  validates :price
  validates :stock
  validates :description
end
