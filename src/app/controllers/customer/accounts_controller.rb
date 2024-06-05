class Customer::AccountsController < ApplicationController
  before_action :authenticate_customer_account!

  def show
    @customer = true
  end

  def edit
    @customer = true
    @current_customer = current_customer
  end

  def update
    @customer = true
    @current_customer = current_customer
    if @current_customer.update(customer_params)
      Stripe::Customer.update(@current_customer.stripe_customer_id,
                              shipping: { name: @current_customer.customer_account.shipping_name,
                                          address: { country: 'JP', postal_code: @current_customer.address.zip_code,
                                                     state: @current_customer.address.prefecture&.name,
                                                     line1: @current_customer.address.street_address, line2: @current_customer.address.street_address_2 } })
      redirect_to account_path, notice: 'アカウント情報が更新されました'
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(customer_account_attributes: %i[id user_name shipping_name email phone_number],
                                     address_attributes: %i[id zip_code prefecture_id street_address street_address_2])
  end
end
