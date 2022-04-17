# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::BrideChildNewsReceiveService
    attr_reader :event, :line_user
    TOP_MENU_MESSAGE = "梓誕生！"
    LEFT_MENU_MESSAGES = ["髪の毛生えるかなぁ", "最新の写真ポーズとは"]
    RIGHT_MENU_MESSAGES = ["酒持ってこぉい", "一升餅ダンス？", "寒中水泳", "カップヌードル", "ごきげんよう"]

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def self.check?(message)
      TOP_MENU_MESSAGE == message || LEFT_MENU_MESSAGES.include?(message) || RIGHT_MENU_MESSAGES.include?(message)
    end

    def call
      case event.message["text"]
      when TOP_MENU_MESSAGE
        message = <<~MESSAGE.chomp
          1992/06/16に埼玉県鶴ヶ島市で五反田家の長女として産まれました！
          親戚の中で一番最初に産まれたので親族みんなから可愛がってもらいました
          うつ伏せをいやがってあまり寝返りをしなかったようで今でもうつ伏せが苦手です笑
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when LEFT_MENU_MESSAGES[0]
        message = <<~MESSAGE.chomp
          髪の毛の生えるのが周りの子よりも遅かったようで心配されていたそうです
          その後無事に生えました！のんびり待つのがいいみたいですね笑
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when LEFT_MENU_MESSAGES[1]
        message = <<~MESSAGE.chomp
        カメラを向けられると毎回このポーズ！
        どうやらピースが上手にできなかったみたいです🤣
        人差し指が若干曲がっているのがポイントです！
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when RIGHT_MENU_MESSAGES[0]
        message = <<~MESSAGE.chomp
        祖母の家が造り酒屋なので小さい時からお酒に囲まれてました
        そんな日常がうかがえる写真です🍶
        MESSAGE
        asset_image = AssetImage.bride_child_news_alchol_image
        Line::PushMessage::ReplySimpleTextWithImageMessageService.new(event:, line_user:, message:, asset_image:, alt_text: event.message["text"]).call
      when RIGHT_MENU_MESSAGES[1]
        message = <<~MESSAGE.chomp
          1歳の頃には一人でしっかり歩けてたようで 一升餅を背負って踊っていたとか...
          そんな姿に親戚一同大爆笑😂
        MESSAGE
        asset_image = AssetImage.bride_child_news_mochi_image
        Line::PushMessage::ReplySimpleTextWithImageMessageService.new(event:, line_user:, message:, asset_image:, alt_text: event.message["text"]).call
      when RIGHT_MENU_MESSAGES[2]
        message = <<~MESSAGE.chomp
          ホテルのプールに入りたがってお父さんと一緒に入りました
          プール最終日で周りのみんなは寒くて誰も入ってなかったとか
          貸切プールを楽しんでました
        MESSAGE
        asset_image = AssetImage.bride_child_news_swim_image
        Line::PushMessage::ReplySimpleTextWithImageMessageService.new(event:, line_user:, message:, asset_image:, alt_text: event.message["text"]).call
      when RIGHT_MENU_MESSAGES[3]
        message = <<~MESSAGE.chomp
          小学生の時にお父さんの仕事の関係で大阪へ！
          当時カップヌードルミュージアムのヌードル作りは完全予約制でお母さんが予約してくれたのですが
          突如関東に帰ることに！
          夢だったマイヌードル作りは叶わなかった。。。

          最近横浜のカップヌードルミュージアムで十数年ぶりのリベンジを果たしたのでした！
        MESSAGE
        asset_image = AssetImage.bride_child_news_noodle_image
        Line::PushMessage::ReplySimpleTextWithImageMessageService.new(event:, line_user:, message:, asset_image:, alt_text: event.message["text"]).call
      when RIGHT_MENU_MESSAGES[4]
        message = <<~MESSAGE.chomp
          中学受験してはいったお嬢様(?)学校
          そこでの挨拶は「起立」「気をつけ」「礼」「ごきげんよう」
          校則は厳しかったですがのびのび育ちました
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      end
    end
  end
end
