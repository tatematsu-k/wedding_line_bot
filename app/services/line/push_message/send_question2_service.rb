# frozen_string_literal: true

class Line::PushMessage::SendQuestion2Service
  attr_reader :event, :line_user, :resend

  def initialize(event:, line_user:, resend: false)
    @event = event
    @line_user = line_user
    @resend = resend
  end

  def call
    if resend
      line_client.reply_message(event["replyToken"], messages)
    else
      message = <<~MESSAGE.chomp
        正解！
        沖縄の本島と離島を1週間かけて行ってました！
        離島の海は本当に綺麗で二人ですごい感動したのでぜひ行ってみてください！！
        また行きたいなと二人で画策してます笑笑

        あともう一問！
        是非考えてみてください！
      MESSAGE
      Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call

      sleep(2)
      line_client.push_message(line_user.line_uid, messages)
    end
  end

  private
    def messages
      [question_message, hint_message]
    end

    def question_message
      {
        type: "template",
        altText: "2つ目の謎",
        template: {
          type: "buttons",
          thumbnailImageUrl: AssetImage.second_question_image.url,
          imageAspectRatio: "square",
          imageSize: "contain",
          title: "2つ目の謎",
          text: "新郎新婦がよく飲んでいるものは？",
          actions: [
            {
              type: "postback",
              label: "緑茶",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion2Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion2Service::CMD_GREEN_TEA,
              ),
            },
            {
              type: "postback",
              label: "紅茶",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion2Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion2Service::CMD_TEA,
              ),
            },
            {
              type: "postback",
              label: "コーヒー",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion2Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion2Service::CMD_COFFEE,
              ),
            },
            {
              type: "postback",
              label: "ワイン",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::AnswerQuestion2Service::SERVICE_NAME,
                cmd: Line::EventHandleService::PostbackService::AnswerQuestion2Service::CMD_WINE,
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
          LINE のメニューから新郎新婦についてみてみよう！
        MESSAGE
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
