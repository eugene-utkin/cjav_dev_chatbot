class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    @chat_message = chat_message
    # Collect the messages for this chat
    #
    # Send those to open ai
    #
    # Send the response back to the chat
  end
end
