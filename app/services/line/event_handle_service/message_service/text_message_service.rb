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
      elsif EventHandleService::MessageService::TextMessageService::GroomChildNewsReceiveService.check?(received_message)
        EventHandleService::MessageService::TextMessageService::GroomChildNewsReceiveService.new(event:, line_user:).call
      elsif EventHandleService::MessageService::TextMessageService::BrideChildNewsReceiveService.check?(received_message)
        EventHandleService::MessageService::TextMessageService::BrideChildNewsReceiveService.new(event:, line_user:).call
      else
        message = "すみません💦メッセージがうまく読み取れませんでした😥"
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
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
          RequestSeatListService,
          RequestMenuService,
          RequestIntroductionService,
        ].detect do |service_class|
          service_class::MESSAGE == message
        end
      end
  end
end
