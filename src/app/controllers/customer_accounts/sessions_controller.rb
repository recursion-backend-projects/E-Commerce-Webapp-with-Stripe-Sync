# frozen_string_literal: true

class CustomerAccounts::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    super do
      reset_session
      flash.clear
    end
  end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(_resource)
    root_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(_resource)
    customer_account_session_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
