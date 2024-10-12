class ChatMessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @chat_message = @chat.chat_messages.create(chat_message_params)
    if @chat_message.save
      render turbo_stream: turbo_stream.append(:chat_messages, @chat_message)
    end
  end

  private

  def chat_messages_params
    params.require(:chat_message).permit(:content)
  end
end
