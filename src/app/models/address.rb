class Address < ApplicationRecord
  has_many :customer, dependent: :destroy
  has_many :admin, dependent: :destroy
end
