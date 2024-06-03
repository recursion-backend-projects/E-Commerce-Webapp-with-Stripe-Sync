class Customer::AccountsController < ApplicationController
  def show
    @customer = true
  end

  def edit
    @customer = true
    @current_customer = current_customer
  end
end
