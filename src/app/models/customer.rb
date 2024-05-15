class Customer < ApplicationRecord
    belongs_to :customer_account
    belongs_to :address
    has_many :wish_products
    has_many :products, through: :wish_products
end
