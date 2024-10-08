class ChatMessagesController < ApplicationController
  def create

  end

  private

  def chat_messages_params
    params.require(:chat_message).permit(:content)
  end
end
