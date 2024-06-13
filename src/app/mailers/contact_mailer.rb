class ContactMailer < ApplicationMailer
    def send_contact_mail(contact)
        @contact = contact
        mail(to: ENV['ADMIN_EMAIL'], subject: 'お問い合わせ') do |format|
            format.html { render template: 'customer/contacts/mailer/send_contact_mail' }
            format.text { render template: 'customer/contacts/mailer/send_contact_mail' }
        end
    end

    def send_user_confirm_mail(contact)
        @contact = contact
        mail(to: @contact.email, subject: 'お問い合わせの確認メール') do |format|
            format.html { render template: 'customer/contacts/mailer/send_user_confirm_mail' }
            format.text { render template: 'customer/contacts/mailer/send_user_confirm_mail' }
        end
    end
end
