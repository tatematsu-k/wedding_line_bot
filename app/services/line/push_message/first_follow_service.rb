# frozen_string_literal: true

class Line::PushMessage::FirstFollowService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], first_text_message)
    sleep(3)
    line_client.push_message(line_user.line_uid, second_message)
  end

  private
    def first_text_message
      {
        type: "text",
        emojis: [
          {
            index: 0,
            productId: "5ac223c6040ab15980c9b44a",
            emojiId: "013",
          }
        ],
        text: <<~MESSAGE.chomp
        $HAPPY WEDDING
        今日はコロナ禍の中、立松と五反田の結婚式に来てくれてありがとうございます
        みなさんと素敵な素敵な時間を過ごせることをとてもとても楽しみにしてました！
        本日少しでも楽しんでいただけると嬉しいです♩
        MESSAGE
      }
    end

    def second_message
      {
        type: "text",
        text: <<~MESSAGE.chomp
        早速ですがまずお名前の入力をお願いします！

        例:
        立松幸樹
        五反田梓
        MESSAGE
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
