class WishProductToken < ApplicationRecord
  belongs_to :customer
  validates :token, length: { maximum: 255 }, uniqueness: true, presence: true

  def self.generate_token
    loop do
      random_token = SecureRandom.urlsafe_base64
      return random_token unless WishProductToken.exists?(token: random_token)
    end
  end
end
