class Customer < ApplicationRecord
  belongs_to :customer_account
  belongs_to :address
  has_many :wish_products, dependent: :destroy
end
