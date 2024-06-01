class Admin::ShippingsController < ApplicationController
  def index
    @admin = true
    @shippings = Shipping.all
  end

  def edit
    @admin = true
    @shipping = Shipping.find(params[:id])
  end

  def update
    @admin = true
    @shipping = Shipping.find(params[:id])

    begin
      if @shipping.update!(shipping_params)
        redirect_to :edit, status: :ok
      else
        render :edit, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = '追跡番号は8文字以上18桁以内、英数字（大文字のみ）有効です'
    end
  end

  private

  def shipping_params
    params.require(:shipping).permit(:carrier, :tracking_number)
  end
end
