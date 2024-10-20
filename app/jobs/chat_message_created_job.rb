class ChatMessageCreatedJob < ApplicationJob
  queue_as :default

  def perform(message)
    # Do something later
  end
end
