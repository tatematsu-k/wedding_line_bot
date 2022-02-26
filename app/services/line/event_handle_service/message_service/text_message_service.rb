# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService
    attr_reader :event

    def initialize(event:)
      @event = event
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
