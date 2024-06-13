class Customer::ContactsController < ApplicationController
    before_action :set_contact_info, only: %i[new]

    def new
        @customer = true
        @contact = Contact.new
        @errors = flash[:errors]
    end

    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            ContactMailer.send_contact_mail(@contact).deliver_now # 管理者向けメール送信
            ContactMailer.send_user_confirm_mail(@contact).deliver_now # ユーザー向けの確認メール送信
            redirect_to root_path, notice: 'メールが送信されました'
        else
            flash[:errors] = @contact.errors.full_messages
            redirect_to new_contact_path(@contact)
        end
    end

    private

    def set_contact_info
        if customer_account_signed_in?
            @contact_name = current_customer_account.shipping_name
            @contact_email = current_customer_account.email
        end
    end

    def contact_params
        params.require(:contact).permit(:email, :name, :message)
    end
end
