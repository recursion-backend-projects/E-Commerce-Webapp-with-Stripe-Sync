class Admin < ApplicationRecord
    belongs_to :customer_account
    belongs_to :address
end