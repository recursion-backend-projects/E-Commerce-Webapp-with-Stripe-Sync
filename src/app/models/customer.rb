class Customer < ApplicationRecord
  belongs_to :customer_account, optional: true
  belongs_to :address, optional: true
  has_many :wish_products, dependent: :destroy
end
