class Admin < ApplicationRecord
  belongs_to :customer_account
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
end
