class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  with_options presence: true do
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }
    validates :order
    validates :product
  end
end
