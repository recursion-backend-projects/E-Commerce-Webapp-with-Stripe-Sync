class NotificationMailer < ApplicationMailer
  def shipping_email
    @email = params[:email]
    @shipping = params[:shipping]
    @order = @shipping.order
    mail(to: @email, subject: "ご注文番号 #{@order.order_number} の商品を発送いたしました。")
  end

  def order_complete_email
    @order = params[:order]
    @download_urls = params[:download_urls] || []
    mail(to: params[:email], subject: "ご注文番号 #{@order.order_number} が完了しました")
  end
end
