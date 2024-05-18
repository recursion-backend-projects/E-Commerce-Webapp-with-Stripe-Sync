class Address < ApplicationRecord
    has_many :customer
    has_many :admin
end