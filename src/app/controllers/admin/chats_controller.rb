class Admin::ChatsController < ApplicationController
  before_action :authenticate_admin_account!

  def index
    @admin = true
    @chats = Chat.where(status: :waiting_for_admin).or(Chat.where(status: :chatting))
  end

  def show
    @admin = true
    @chat = Chat.find(params[:id])

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
      logger.debug token
      # TODO: goにトークンを渡す
    end
  end

  private

  def admin_has_valid_token?
    token = cookies.signed[:jwt]
    decoded_token = Admin.decode_jwt(token)
    logger.debug(decoded_token)
    decoded_token.present? && decoded_token['admin_id'].to_i == @current_admin.id
  end
end
