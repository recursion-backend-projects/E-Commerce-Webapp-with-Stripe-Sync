class Customer::ChatsController < ApplicationController
  before_action :authenticate_customer_account!
  def show
    @customer = true
    @websocket_url = Rails.env.production? ? ENV.fetch('WEBSOCKET_URL', nil) : 'ws://localhost:8080/chat'

    @current_customer.create_chat(status: :waiting_for_admin) if @current_customer.chat.blank?

    if @current_customer && customer_has_valid_token?
      @current_customer.chat.update(status: :waiting_for_admin)
    else
      # 有効なトークンを持っていない場合は再作成
      token = @current_customer.generate_jwt
      cookies.signed[:customer_jwt] = {
        value: token,
        httponly: true,
        secure: Rails.env.production?, # 本番環境では true
        same_site: :strict
      }
    end
  end

  def token
    render json: { token: cookies.signed[:customer_jwt] }
  end

  private

  def customer_has_valid_token?
    token = cookies.signed[:customer_jwt]
    decoded_token = Customer.decode_jwt(token)
    decoded_token.present? && decoded_token['customer_id'].to_i == @current_customer.id
  end
end
