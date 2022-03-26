# frozen_string_literal: true

class Line::PushMessage::SendQuestion1Service
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], [question_message, hint_message])
  end

  private
    def question_message
      {
        type: "template",
        altText: "1つ目の謎",
        template: {
          type: "buttons",
          thumbnailImageUrl: AssetImage.first_question_image.url,
          imageAspectRatio: "square",
          imageSize: "contain",
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

    def hint_message
      {
        type: "text",
        text: <<~MESSAGE.chomp
          ヒント！
          大きな木の下に新婚旅行の写真が飾ってあるよ
        MESSAGE
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
