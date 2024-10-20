class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # Collect the messages for this chat
  end
end
