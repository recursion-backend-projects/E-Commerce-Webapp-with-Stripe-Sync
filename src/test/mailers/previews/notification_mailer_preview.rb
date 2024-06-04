class NotificationMailerPreview < ActionMailer::Preview
  def shipping_email
    NotificationMailer.with(email: 'test@gmail.com', order: Order.first, shipping: Shipping.first).shipping_email
  end
end
