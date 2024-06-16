class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin_account!

  def index
    @admin = true
    @chats = Chat.where(status: :waiting_for_admin).or(Chat.where(status: :chatting))
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

  private

  def admin_has_valid_token?
    token = cookies.signed[:admin_jwt]
    decoded_token = Admin.decode_jwt(token)
    logger.debug(decoded_token)
    if decoded_token.present? &&
      decoded_token['admin_id'].to_i == @current_admin.id &&
      decoded_token['customer_id'].to_i == params[:id].to_i
     return true
    else
      logger.debug("Invalid token or ID mismatch: admin_id=#{decoded_token['admin_id']}, customer_id=#{decoded_token['customer_id']}, params_id=#{params[:id]}")
      return false
   end
  end
end
