class ProductReview < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :title, presence: true, length: { maximum: 50 }
  validates :review, presence: true, length: { maximum: 400 }
  validates :rating, presence: true, inclusion: { in: 1..5 }

  delegate :customer_account, to: :customer
end
