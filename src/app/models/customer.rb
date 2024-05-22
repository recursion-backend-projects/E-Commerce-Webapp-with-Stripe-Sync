class Customer < ApplicationRecord
  belongs_to :customer_account
  has_one :address, as: :addressable, dependent: :destroy
  has_many :wish_products, dependent: :destroy

  before_save :set_address

  private

  def set_address
    self.address_id ||= self.address.id if self.address
  end
end
