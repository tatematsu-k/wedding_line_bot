# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::RequestIntroductionGroomService
    SERVICE_NAME = "request_introduction_groom"
    CMD_ABOUT_CHILD = "child"
    CMD_ABOUT_JOB = "job"
    CMD_ABOUT_HOBBY = "hobby"

    attr_reader :event, :line_user, :cmd

    def initialize(event:, line_user:, cmd:)
      @event = event
      @line_user = line_user
      @cmd = cmd
    end

    def call
      if line_user.question_status_wait_answer2?
        case cmd
        when CMD_ABOUT_CHILD
          Line::PushMessage::GroomChildService.new(event:, line_user:).call
        when CMD_ABOUT_JOB
          Line::PushMessage::GroomJobService.new(event:, line_user:).call
        when CMD_ABOUT_HOBBY
          Line::PushMessage::GroomHobbyService.new(event:, line_user:).call
        end
      end
    end
  end
end
