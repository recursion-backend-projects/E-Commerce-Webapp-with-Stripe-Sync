class Customer < ApplicationRecord
  has_many :wish_products, dependent: :destroy
  has_many :favorite_products, dependent: :destroy
  has_many :download_products, dependent: :destroy
  has_many :product_reviews, dependent: :destroy
  has_one :customer_account, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable
  has_many :orders, dependent: :destroy
  has_one :chat, dependent: :destroy

  accepts_nested_attributes_for :customer_account
  accepts_nested_attributes_for :address

  def generate_jwt
    hmac_secret = ENV.fetch('JWT_SECRET_KEY')
    payload = { type: 'create', customer_id: id, exp: 8.hours.from_now.to_i }
    JWT.encode(payload, hmac_secret, 'HS256')
  end

  def self.decode_jwt(token)
    decoded = JWT.decode(token, ENV.fetch('JWT_SECRET_KEY'), true, { algorithm: 'HS256' })
    decoded[0] # デコードしたペイロードを返す
  rescue JWT::ExpiredSignature, JWT::DecodeError
    nil
  end
end
