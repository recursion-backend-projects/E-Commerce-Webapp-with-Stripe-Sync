class Customer::ChatsController < ApplicationController
  before_action :authenticate_customer_account!
  def show
    @customer = true
  end
end
