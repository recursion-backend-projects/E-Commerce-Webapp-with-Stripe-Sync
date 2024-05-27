class ProductReview < ApplicationRecord
    belongs_to :customer
    belongs_to :product
  
    validates :rating, presence: true, inclusion: { in: 1..5 }
    validates :title, presence: true
    validates :review, presence: true

    def customer_account
        customer.customer_account
    end
end
