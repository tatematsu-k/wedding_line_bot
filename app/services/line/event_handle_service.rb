# frozen_string_literal: true

module Line
  class EventHandleService
    attr_reader :event

    def initialize(event:)
      @event = event
    end

    def call
      line_user = LineUser.find_or_create_by!(line_uid: event["source"]["userId"])
      event_service_class(line_user:).call
    end

    private
      def event_service_class(line_user:)
        case event
        when Line::Bot::Event::Message
          MessageService.new(event:, line_user:)
        when Line::Bot::Event::Follow
          FollowService.new(event:, line_user:)
        when Line::Bot::Event::Unfollow
          UnfollowService.new(event:, line_user:)
        end
      end
  end
end
