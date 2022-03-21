# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::NameConfirmService
    SERVICE_NAME = "name_confirm"
    CMD_YES = "yes"
    CMD_NO = "no"

    attr_reader :event, :line_user, :invited_user_id, :cmd

    def initialize(event:, line_user:, invited_user_id:, cmd:)
      @event = event
      @line_user = line_user
      @invited_user_id = invited_user_id
      @cmd = cmd
    end

    def call
      case cmd
      when CMD_YES
        line_user.create_user_activation!(invited_user:)

        PushMessage::ApproveUserNameConfirmationService.new(event:, line_user:, invited_user:).call
      when CMD_NO
        PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message: "お手数ですが再度お名前を送信してください。").call
      end
    end

    private
      def invited_user
        @invited_user ||= InvitedUser.find(invited_user_id)
      end
  end
end
