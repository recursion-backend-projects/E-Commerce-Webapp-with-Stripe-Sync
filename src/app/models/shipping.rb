class Shipping < ApplicationRecord
  belongs_to :order
  enum :status, { pending: 0, shipped: 1 }, default: :pending, validate: true
  enum :carrier, { sagawa: 0, yamato: 1, nihon_yubin: 2, seinou: 3, hukuyama: 4 }
  validates :carrier, inclusion: { in: carriers.keys.map(&:to_s) }, on: :update
  validates :tracking_number, uniqueness: true, length: { in: 8..18 }, format: { with: /\A[A-Z0-9]+\z/ }, on: :update
end
