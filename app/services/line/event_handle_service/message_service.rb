# frozen_string_literal: true

module Line
  class EventHandleService::MessageService
    attr_reader :event

    def initialize(event:)
      @event = event
    end

    def call
      event_service_class.call
    end

    private
      def event_service_class
        case event.type
        when Line::Bot::Event::MessageType::Text
          TextMessageService.new(event:)
        end
      end
  end
end
