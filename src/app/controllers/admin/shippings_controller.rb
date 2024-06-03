class Admin::ShippingsController < ApplicationController
  def index
    @admin = true
    @shippings = Shipping.all.order(created_at: :desc)
  end

  def edit
    @admin = true
    @shipping = Shipping.find(params[:id])
  end

  def update
    @admin = true
    @shipping = Shipping.find(params[:id])

    if @shipping.update(shipping_params)
      @shipping.update(status: :shipped, shipping_at: Time.current)

      expires_now
      redirect_to edit_admin_shipping_path(@shipping), notice: '商品発送の通知メールを送信しました'

      email = @shipping.order.guest_email? ? @shipping.order.guest_email : @shipping.order.customer.customer_account.email

      # 発送通知メールを顧客に送信
      NotificationMailer.with(email:, shipping: @shipping).shipping_email.deliver_later
    else
      flash.now[:alert] = '正しい値を入力してください'
      render :edit, status: :unprocessable_entity

    end
  end

  private

  def shipping_params
    params.require(:shipping).permit(:carrier, :tracking_number)
  end
end
