class Admin < ApplicationRecord
  has_one :admin_account, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy, inverse_of: :addressable

  include JwtAuthenticable

  def generate_jwt(customer_id)
    payload = { type: 'join', customer_id:, admin_id: id, exp: 8.hours.from_now.to_i }
    super(payload)
  end
end
