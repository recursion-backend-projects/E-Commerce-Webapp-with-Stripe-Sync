class Admin::ChatsController < ApplicationController
  def index
    @admin = true
    @chats = Chat.where(status: :waiting_for_admin).or(Chat.where(status: :chatting))
  end

  def show
    @admin = true
    @chat = Chat.find(params[:id])
  end
end
