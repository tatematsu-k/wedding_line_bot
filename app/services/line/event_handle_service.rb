# frozen_string_literal: true

module Line
  class EventHandleService
    attr_reader :event

    def initialize(event:)
      @event = event
    end

    def call
      event_service_class.call
    end

    private
      def event_service_class
        case event
        when Line::Bot::Event::Message
          MessageService.new(event:)
        end
      end
  end
end
