class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # Collect the messages for this chat
    #
    # Send those to open ai
  end
end
