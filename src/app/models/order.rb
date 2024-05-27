class Order < ApplicationRecord
  belongs_to :customer, optional: true
  before_create :generate_order_number

  with_options presence: true do
    validates :order_number, uniqueness: true
    validates :total, numericality: { only_integer: true }
    validates :order_date
  end

  validates :guest_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
  validates_associated :customer, allow_nil: true

  private

  def generate_order_number
    loop do
      self.order_number = SecureRandom.hex(6)
      break unless Order.exists?(order_number:)
    end
  end
end
