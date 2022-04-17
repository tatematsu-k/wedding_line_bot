# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::RequestIntroductionService
    MESSAGE = "新郎新婦について"

    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      PushMessage::RequestIntroductionService.new(event:, line_user:).call
    end
  end
end
