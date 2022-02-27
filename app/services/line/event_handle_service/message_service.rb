# frozen_string_literal: true

module Line
  class EventHandleService::MessageService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      event_service_class.call
    end

    private
      def event_service_class
        case event.type
        when Line::Bot::Event::MessageType::Text
          TextMessageService.new(event:, line_user:)
        end
      end
  end
end
