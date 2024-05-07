# frozen_string_literal: true

class AdminAccounts::ConfirmationsController < Devise::ConfirmationsController
  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  # def show
  #   super
  # end

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    flash[:notice] = '確認メールを再送しました。メールを確認してください。'
    new_admin_account_confirmation_path
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    # TODO: 遷移先をダッシュボードに変更する
    '/sample'
  end
end
