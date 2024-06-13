class Admin::ChatsController < ApplicationController
  def index
    @admin = true
  end

  def show
    @admin = true
  end
end
