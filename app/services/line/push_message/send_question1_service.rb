# frozen_string_literal: true

class Line::PushMessage::SendQuestion1Service
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], confirm_message(invited_user))
  end

  private
    def question_message
      {
        type: "template",
        altText: "This is a buttons template",
        template: {
          type: "buttons",
          thumbnailImageUrl: "https://example.com/bot/images/image.jpg",
          title: "1つ目の謎",
          text: "新婚旅行で行ったのはどこでしょう？",
          actions: [
            {
              type: "postback",
              label: "北海道",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion1Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion1Service::CMD_HOKKAIDO,
              ),
            },
            {
              type: "postback",
              label: "京都",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion1Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion1Service::CMD_KYOTO,
              ),
            },
            {
              type: "postback",
              label: "大阪",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion1Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion1Service::CMD_OSAKA,
              ),
            },
            {
              type: "postback",
              label: "沖縄",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion1Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion1Service::CMD_OKINAWA,
              ),
            },
          ]
        }
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
