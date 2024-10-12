class ChatMessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @chat_message = @chat.chat_messages.create(chat_message_params)
  end

  private

  def chat_messages_params
    params.require(:chat_message).permit(:content)
  end
end
