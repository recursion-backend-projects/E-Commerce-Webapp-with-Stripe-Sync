class Order < ApplicationRecord
  belongs_to :customer, optional: true
  has_many :order_items, dependent: :destroy

  with_options presence: true do
    validates :order_number, uniqueness: true, length: { is: 19 }, format: { with: /\A\d{3}-\d{7}-\d{7}\z/ }
    validates :total, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :order_date
    validates :receipt_url, format: { with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/ }
  end

  validates :guest_email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_nil: true
end
