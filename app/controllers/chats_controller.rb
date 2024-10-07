class ChatsController < ApplicationController
  def index
    @chats = Chat.all
  end

  def show
    @chat = Chat.find_by(session_id: params[:id])
  end

  def create
    @chat = Chat.create!
  end
end
