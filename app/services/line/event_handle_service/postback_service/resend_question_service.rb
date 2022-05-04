# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::ResendQuestionService
    SERVICE_NAME = "resend_question"
    CMD_RESEND = "resend"

    attr_reader :event, :line_user, :cmd

    def initialize(event:, line_user:, cmd:)
      @event = event
      @line_user = line_user
      @cmd = cmd
    end

    def call
      case cmd
      when CMD_RESEND
        if line_user.question_status_wait_answer1?
          PushMessage::SendQuestion1Service.new(event:, line_user:).call
        elsif line_user.question_status_wait_answer2?
          PushMessage::SendQuestion2Service.new(event:, line_user:, resend: true).call
        end
      end
    end
  end
end
