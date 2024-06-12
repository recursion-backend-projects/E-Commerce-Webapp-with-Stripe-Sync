class Customer::ChatsController < ApplicationController
  before_action :authenticate_customer_account!
  def show
    @customer = true

    # 有効なトークンを既に持っているか確認
    if @current_customer && user_has_valid_token?
      if @current_customer.chat.present?
        @current_customer.chat.status = :waiting_for_admin
      else
        Chat.create(customer: @current_customer)
      end
    else
      # 有効なトークンを持っていない場合は再作成
      token = @current_customer.generate_jwt
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

  def user_has_valid_token?
    token = cookies.signed[:jwt]
    decoded_token = Customer.decode_jwt(token)
    decoded_token.present? && decoded_token['customer_id'].to_i == @current_customer.id
  end
end
