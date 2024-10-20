class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    # Do something later
  end
end
