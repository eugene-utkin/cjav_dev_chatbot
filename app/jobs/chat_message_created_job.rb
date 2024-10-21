class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    @chat_message = chat_message

    # Send those to open ai
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo"
      }
    )

    # Send the response back to the chat
  end

  def messages
    # Collect the messages for this chat
    @chat_message
      .chat
      .chat_messages
      .order(created_at: :asc)
      .map do |m|
        {
          content: m.content,
          role: m.role
        }
      end
  end
end
