# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      if line_user.invited_user.nil?
        CheckUserNameService.new(event:, line_user:).call
      elsif service_class = find_target_service_class(received_message)
        service_class.new(event:, line_user:).call
      else
        # 未対応のものは一旦受け取った文言を返す
        message = { type: "text", text: received_message }
        client.reply_message(event["replyToken"], message)
      end
    end

    private
      def received_message
        event.message["text"]
      end

      def client
        @client ||= LineClient.build
      end

      def find_target_service_class(message)
        [
          ClickStartQuestionService,
          RequestSeatListService
        ].detect do |service_class|
          service_class::MESSAGE == message
        end
      end
  end
end
