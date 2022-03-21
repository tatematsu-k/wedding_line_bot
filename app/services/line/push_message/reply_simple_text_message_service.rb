# frozen_string_literal: true

class Line::PushMessage::ReplySimpleTextMessageService
  attr_reader :event, :line_user, :message

  def initialize(event:, line_user:, message:)
    @event = event
    @line_user = line_user
    @message = message
  end

  def call
    line_client.reply_message(event["replyToken"], message_obj)
  end

  private
    def message_obj
      {
        type: "text",
        text: message,
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
