# frozen_string_literal: true

class Line::PushMessage::ApproveUserNameConfirmationService
  attr_reader :event, :line_user, :invited_user

  def initialize(event:, line_user:, invited_user:)
    @event = event
    @line_user = line_user
    @invited_user = invited_user
  end

  def call
    line_client.reply_message(event["replyToken"], messages)
  end

  private
    def messages
      [
        {
          type: "text",
          text: <<~MESSAGE.chomp
            #{invited_user.name}様
            本日はお越しいただきありがとうございます。
            新郎新婦からメッセージが届いております。
          MESSAGE
        },
        {
          type: "text",
          text: invited_user.init_message,
        }
      ]
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
