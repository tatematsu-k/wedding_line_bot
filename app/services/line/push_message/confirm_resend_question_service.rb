# frozen_string_literal: true

class Line::PushMessage::ConfirmResendQuestionService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], confirm_message(invited_user))
  end

  private
    def confirm_message(invited_user)
      {
        type: "template",
        altText: text,
        template: {
          type: "confirm",
          text: text,
          actions: [
            {
              type: "postback",
              label: "再送信",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::ResendQuestionService::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::ResendQuestionService::CMD_RESEND,
              ),
            }
          ]
        }
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end

    def text
      @text ||=
        case line_user.question_status
        when "wait_answer1"
          "謎は見つかりましたか？もう一度謎を確認しますか？"
        when "wait_answer2"
          "既に謎を解明したんですね！この調子で二つ目の謎も解いてみてください！もう一度謎を確認しますか？"
        end
    end
end
