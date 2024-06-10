class ContactMailer < ApplicationMailer
    def send_mail(contact)
        @contact = contact
        mail(to: @contact.email, subject: 'お問い合わせ') do |format|
            format.html { render template: 'customer/contacts/mailer/send_mail' }
            format.text { render template: 'customer/contacts/mailer/send_mail' }
        end
    end
end
