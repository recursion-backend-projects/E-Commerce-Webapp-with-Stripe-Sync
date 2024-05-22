class Address < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :admin, optional: true
end
