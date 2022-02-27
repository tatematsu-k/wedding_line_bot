# frozen_string_literal: true

module Line
  class EventHandleService::FollowService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      line_user.follow!
    end
  end
end
