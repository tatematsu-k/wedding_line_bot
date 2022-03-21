# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::ClickStartQuestionService
    CMD = "謎解き開始！"
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      if line_user.question_status_not_started?
        line_user.question_status_wait_answer1!
        PushMessage::SendQuestion1Service.new(event:, line_user:).call
      else
        PushMessage::ConfirmResendQuestionService.new(event:, line_user:).call
      end
    end
  end
end
