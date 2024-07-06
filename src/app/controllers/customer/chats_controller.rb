class Customer::ChatsController < ApplicationController
  before_action :authenticate_customer_account!
  def show
    @customer = true
    @websocket_url = Rails.env.production? ? ENV.fetch('WEBSOCKET_URL', nil) : 'ws://localhost:8080/chat'
    @chat = current_customer.chat

    if @chat.blank?
      chat = @current_customer.create_chat(status: :waiting_for_admin)
      ActionCable.server.broadcast 'chat_channel', { action: 'create', chat:, customer_account: @current_customer.customer_account }
    end

    if @current_customer && customer_has_valid_token?
      @current_customer.chat.update(status: :waiting_for_admin)
      ActionCable.server.broadcast 'chat_channel', { action: 'create', chat: @chat, customer_account: @current_customer.customer_account }
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

  def update_status
    @chat = current_customer_account.customer.chat
    if @chat.update(status: params[:status])
      ActionCable.server.broadcast 'chat_channel', {
        action: 'update_status',
        chat: @chat.as_json
      }
      render json: { status: 'ok' }
    else
      render json: { status: 'error', message: @chat.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def customer_has_valid_token?
    token = cookies.signed[:customer_jwt]
    decoded_token = Customer.decode_jwt(token)
    decoded_token.present? && decoded_token['customer_id'].to_i == @current_customer.id
  end
end
