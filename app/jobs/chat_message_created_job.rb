class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(chat_message)
    @chat_message = chat_message

    # Create a new chat message with the response
    system_message = ChatMessage.create!(
      role: "system",
      content: "Thinking...",
      chat: @chat_message.chat
    )

    # Send the response back to the chat
    Turbo::StreamsChannel.broadcast_append_to(
      "chat_messages_#{chat_message.chat.id}",
      target: "chat_messages_#{chat_message.chat.id}",
      partial: "chat_messages/chat_message",
      locals: { chat_message: system_message }
    )

    # Send those to open ai
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: messages,
        temperature: 0.9,
        max_tokens: 150
      }
    )
    answer = response.dig("choices", 0, "message", "content")
    puts "Got response: #{answer}"

    system_message.update!(content: answer)

    # Send the response back to the chat
    Turbo::StreamsChannel.broadcast_replace_to(
      "chat_messages_#{chat_message.chat.id}",
      target: "chat_message_#{system_message.id}",
      partial: "chat_messages/chat_message",
      locals: { chat_message: system_message }
    )
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

  private

  def client = OpenAI::Client.new(access_token: Rails.application.credentials.open_ai[:key])
end
