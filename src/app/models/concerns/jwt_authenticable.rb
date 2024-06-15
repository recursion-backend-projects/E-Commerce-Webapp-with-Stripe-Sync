# app/models/concerns/jwt_authenticable.rb
module JwtAuthenticable
  extend ActiveSupport::Concern
  # インスタンスメソッド
  def generate_jwt(payload)
    hmac_secret = ENV.fetch('JWT_SECRET_KEY')
    JWT.encode(payload, hmac_secret, 'HS256')
  end

  class_methods do
    # クラスメソッド
    def decode_jwt(token)
      hmac_secret = ENV.fetch('JWT_SECRET_KEY')
      begin
        decoded = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
        decoded[0] # デコードしたペイロードを返す
      rescue JWT::ExpiredSignature, JWT::DecodeError
        nil
      end
    end
  end
end
