class Customer < ApplicationRecord
  belongs_to :customer_account, inverse_of: :customer
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
  has_many :wish_products, dependent: :destroy
  has_many :favorite_products, dependent: :destroy

  before_save :set_address

  private

  def set_address
    self.address_id ||= address.id if address
  end
end
