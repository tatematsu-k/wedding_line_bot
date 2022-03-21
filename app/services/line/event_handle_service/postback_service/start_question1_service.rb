# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::StartQuestion1Service
    SERVICE_NAME = "start_question1"
    CMD_YES = "yes"
    CMD_NO = "no"

    attr_reader :event, :line_user, :cmd

    def initialize(event:, line_user:, cmd:)
      @event = event
      @line_user = line_user
      @cmd = cmd
    end

    def call
      case cmd
      when CMD_YES
        line_user.question_status_wait_answer1!
        PushMessage::SendQuestion1Service.new(event:, line_user:).call
      when CMD_NO
        PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message: "もし参加される場合にはいつでも初めてみてください").call
      end
    end
  end
end
