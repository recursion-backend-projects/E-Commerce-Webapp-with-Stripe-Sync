class Customer < ApplicationRecord
  has_many :wish_products, dependent: :destroy
  has_many :favorite_products, dependent: :destroy
  has_many :product_reviews, dependent: :destroy
  has_one :customer_account, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
end
