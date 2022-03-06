# frozen_string_literal: true

class Line::PushMessage::UserNameNotFoundService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], user_not_found_message)
  end

  private
    def user_not_found_message
      {
        type: "text",
        text: <<~MESSAGE.chomp
          申し訳ございません。
          お名前の確認に失敗しました。
          お手数ですが再度お名前の入力をお願いします。
        MESSAGE
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
