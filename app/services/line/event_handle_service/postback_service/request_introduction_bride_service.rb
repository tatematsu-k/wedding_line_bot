# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::RequestIntroductionBrideService
    SERVICE_NAME = "request_introduction_bride"
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
          Line::PushMessage::BrideChildService.new(event:, line_user:).call
        when CMD_ABOUT_JOB
          Line::PushMessage::BrideJobService.new(event:, line_user:).call
        when CMD_ABOUT_HOBBY
          Line::PushMessage::BrideHobbyService.new(event:, line_user:).call
        end
      end
    end
  end
end
