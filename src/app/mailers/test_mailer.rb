class TestMailer < ApplicationMailer
    default from: 'from@example.com'

    def send_test_email(email)
        mail(to: email, subject: 'Test Email from Rails', body: 'This is a test email sent from Rails.')
    end
end
