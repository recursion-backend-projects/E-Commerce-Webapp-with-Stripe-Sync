class NotificationMailer < ApplicationMailer
  def shipping_email
    @email = params[:email]
    @shipping = params[:shipping]
    @order = @shipping.order
    mail(to: @email, subject: "ご注文番号 #{@order.order_number} の商品を発送いたしました。")
  end
end
