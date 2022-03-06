# frozen_string_literal: true

class Line::PushMessage::RejectUserNameConfirmationService
  attr_reader :event, :line_user, :invited_user

  def initialize(event:, line_user:, invited_user:)
    @event = event
    @line_user = line_user
    @invited_user = invited_user
  end

  def call
    line_client.reply_message(event["replyToken"], message)
  end

  private
    def message
      {
        type: "text",
        text: <<~MESSAGE.chomp
          お手数ですが再度お名前を送信してください。
        MESSAGE
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
