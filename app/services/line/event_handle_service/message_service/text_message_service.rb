# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      message = { type: "text", text: received_message }
      client.reply_message(event["replyToken"], message)
    end

    private
      def received_message
        event.message["text"]
      end

      def client
        @client ||= LineClient.build
      end
  end
end
