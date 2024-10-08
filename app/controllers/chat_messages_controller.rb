class ChatMessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
  end

  private

  def chat_messages_params
    params.require(:chat_message).permit(:content)
  end
end
