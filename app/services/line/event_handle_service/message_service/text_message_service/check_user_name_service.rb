# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::CheckUserNameService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      invited_user = find_invited_user

      PushMessage::ConfirmUserNameService.new(event:, line_user:, invited_user:).call
    rescue ActiveRecord::RecordNotFound
      PushMessage::UserNameNotFoundService.new(event:, line_user:).call
    end

    private
      def find_invited_user
        InvitedUser.find_by!(name: event.message["text"].delete(" "))
      end
  end
end
