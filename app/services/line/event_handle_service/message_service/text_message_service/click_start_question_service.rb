# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::ClickStartQuestionService
    CMD = "開演までの時間をワクワクに"
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      if line_user.question_status_not_started?
        Line::PushMessage::ConfirmStartQuestionService.new(event:, line_user:).call
      else
        PushMessage::ConfirmResendQuestionService.new(event:, line_user:).call
      end
    end
  end
end
