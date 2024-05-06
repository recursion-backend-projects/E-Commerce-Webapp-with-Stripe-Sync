# frozen_string_literal: true

class AdminAccounts::SessionsController < Devise::SessionsController
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
  # def destroy
  #   super
  # end

  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    # TODO: ダッシュボード画面のパスに変更する
    '/sample'
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource)
    # TODO: ダッシュボード画面のパスに変更する
    '/admin_accounts/sign_in'
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
