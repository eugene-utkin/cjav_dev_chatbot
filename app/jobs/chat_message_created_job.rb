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

  def messages
    @chat_message
      .chat
      .chat_messages
      .order(created_at: :asc)
      .map do |m|
        {

        }
      end
  end
end
