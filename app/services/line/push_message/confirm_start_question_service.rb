# frozen_string_literal: true

class Line::PushMessage::ConfirmStartQuestionService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], confirm_message)
  end

  private
    def confirm_message
      {
        type: "template",
        altText: text,
        template: {
          type: "confirm",
          text: text,
          actions: [
            {
              type: "postback",
              label: "参加！",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::StartQuestion1Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::StartQuestion1Service::CMD_YES,
              ),
            },
            {
              type: "postback",
              label: "今回は未参加",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::StartQuestion1Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::StartQuestion1Service::CMD_NO,
              ),
            }
          ]
        }
      }
    end

    def text
      <<~MESSAGE
        披露宴までの間の時間つぶしとして少しだけ謎解きを用意しました。
        新郎新婦について知るきっかけになるのでぜひ参加してください！
        選択式で時間制限もないのでお気軽にご参加ください笑
      MESSAGE
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
