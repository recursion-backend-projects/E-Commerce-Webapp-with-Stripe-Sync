class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin_account!

  def index
    @admin = true
    @chats = Chat.where(status: :waiting_for_admin).or(Chat.where(status: :chatting)).page(params[:page])
  end

  def show
    @admin = true
    @chat = Chat.find(params[:id])
    @websocket_url = Rails.env.production? ? "wss://#{request.domain}/chat" : 'ws://localhost:8080/chat'

    # 有効なトークンを既に持っているか確認
    if @current_admin && admin_has_valid_token?
      @chat.status = :chatting
    else
      # 有効なトークンを持っていない場合は再作成
      token = @current_admin.generate_jwt(@chat.customer_id)
      cookies.signed[:jwt] = {
        value: token,
        httponly: true,
        secure: Rails.env.production?, # 本番環境では true
        same_site: :strict
      }
    end
  end

  def token
    render json: { token: cookies.signed[:jwt] }
  end

  private

  def admin_has_valid_token?
    token = cookies.signed[:jwt]
    decoded_token = Admin.decode_jwt(token)
    logger.debug(decoded_token)
    decoded_token.present? && decoded_token['admin_id'].to_i == @current_admin.id
  end
end
