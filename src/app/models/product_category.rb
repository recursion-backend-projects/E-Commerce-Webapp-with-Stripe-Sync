class ProductCategory < ApplicationRecord
  validates :name, presence: true
end
