class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin_account!

  def index
    cookies.delete(:admin_jwt)
    @admin = true
    @chats = Chat.where(status: :waiting_for_admin).or(Chat.where(status: :chatting)).page(params[:page])
  end

  def show
    @admin = true
    @chat = Chat.find(params[:id])
    @customer_account = @chat.customer.customer_account
    @websocket_url = Rails.env.production? ? ENV.fetch('WEBSOCKET_URL', nil) : 'ws://localhost:8080/chat'

    # 有効なトークンを既に持っているか確認
    if @current_admin && admin_has_valid_token?
      @chat.status = :chatting
    else
      # 有効なトークンを持っていない場合は再作成
      token = @current_admin.generate_jwt(@chat.customer_id)
      cookies.signed[:admin_jwt] = {
        value: token,
        httponly: true,
        secure: Rails.env.production?, # 本番環境では true
        same_site: :strict
      }
    end
  end

  def token
    render json: { token: cookies.signed[:admin_jwt] }
  end

  def update_status
    @chat = Chat.find(params[:id])
    if @chat.update(status: params[:status])
      ActionCable.server.broadcast 'chat_channel', { action: 'update_status', chat: @chat }
      render json: { status: 'ok' }
    else
      render json: { status: 'error', message: @chat.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def admin_has_valid_token?
    token = cookies.signed[:admin_jwt]
    decoded_token = Admin.decode_jwt(token)
    if decoded_token.present?
      logger.debug(decoded_token)
      admin_id = decoded_token['admin_id'].to_i
      customer_id = decoded_token['customer_id'].to_i
      if admin_id == @current_admin.id && customer_id == params[:id].to_i
        true
      else
        logger.debug("Invalid token or ID mismatch: admin_id=#{admin_id}, customer_id=#{customer_id}, params_id=#{params[:id]}")
        false
      end
    else
      logger.debug('Token is invalid or could not be decoded')
      false
    end
  end
end
