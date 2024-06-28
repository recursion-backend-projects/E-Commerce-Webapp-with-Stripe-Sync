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

  def self.generate_order_number
    generate_random_digit = ->(digit) { Array.new(digit) { rand(10) }.join }

    loop do
      new_order_number = "#{generate_random_digit.call(3)}-#{generate_random_digit.call(7)}-#{generate_random_digit.call(7)}"

      return new_order_number unless Order.exists?(order_number: new_order_number)
    end
  end
end
