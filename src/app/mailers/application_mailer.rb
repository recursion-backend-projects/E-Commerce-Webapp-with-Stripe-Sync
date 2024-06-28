class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('ADMIN_EMAIL', nil)
  layout 'mailer'
end
