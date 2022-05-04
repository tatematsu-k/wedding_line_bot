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
        type: :text,
        text: <<~TEXT.chomp
          第二問！

          最近流行？のポーズで写真を撮って新郎新婦宛に送ってください！
          送ってくれた方には式が終わった後に新郎新婦からささやかな贈り物があるかも！？
        TEXT
      }
    end

    def hint_message
      {
        type: "text",
        text: <<~MESSAGE.chomp
          ヒント！
          この LINE の中に答えがあるかも！
          メニューから新郎新婦についていろいろ見てみよう

          最近の前撮りの写真でも撮影の合間に自撮りで撮ったようですよ
        MESSAGE
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
