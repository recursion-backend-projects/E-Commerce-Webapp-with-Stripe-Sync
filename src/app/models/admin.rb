class Admin < ApplicationRecord
  has_one :admin_account, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
end
