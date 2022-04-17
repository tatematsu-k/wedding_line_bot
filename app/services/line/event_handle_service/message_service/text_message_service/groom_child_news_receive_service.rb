# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::GroomChildNewsReceiveService
    attr_reader :event, :line_user
    TOP_MENU_MESSAGE = "幸樹誕生！"
    LEFT_MENU_MESSAGES = ["20年続いた合気道", "卒業旅行は鳥取島根！なぜ？"]
    RIGHT_MENU_MESSAGES = ["苦いお薬はいや！", "インターナショナルな入園試験！？", "国語が苦手な原因は？", "水泳部部長就任秘話", "得意で大学受験"]

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
          1993/09/25に埼玉県上尾市で立松家の次男として産まれました！
          産まれた時には周りの子よりも一回り大きかったそうです
          それでも家族の男性陣の中では小さかったんだとか
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when LEFT_MENU_MESSAGES[0]
        message = <<~MESSAGE.chomp
          兄が合気道をやっており幼稚園生の頃からよく道場に出入りしていました
          行くたびに先生方から幸樹はやらないのか？と言われており
          その度に「僕は小学生になったらやるんだ！」と言ってたそうです笑

          今はお休みをいただいていますがつい最近まで兄弟揃ってずっと通っていました
        MESSAGE
        asset_image = AssetImage.groom_child_news_aikido_image
        Line::PushMessage::ReplySimpleTextWithImageMessageService.new(event:, line_user:, message:, asset_image:, alt_text: event.message["text"]).call
      when LEFT_MENU_MESSAGES[1]
        message = <<~MESSAGE.chomp
          大学では生協学生委員会という団体で活動していました
          そこで大学内のイベント(オフィシャルの入学前歓迎会やオープンキャンパスなど)の企画運営をやっていました

          卒業旅行では誰も行かなさそうなところにいこう！という企画で島根鳥取に行ってきました😅
          着くとすぐに閑散とした商店街で次の電車まで1時間というのんびり旅になりました笑
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when RIGHT_MENU_MESSAGES[0]
        message = <<~MESSAGE.chomp
          2歳ごろに検診でお医者さんに行った時に動かないようにということで睡眠導入剤を飲んで寝てるうちに検診というのがあったのですが
          そのお薬が美味しくなかったらしく笑
          頑なに飲むことをいやがって母親を困らせたそうです

          結果「動かずにいられたら飲まなくてもいいよ」という約束をして微動だにせず健診をやり遂げたそうです！
          小さいことから一度決めたことはやり通す頑固さを持った子どもでした笑
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when RIGHT_MENU_MESSAGES[1]
        message = <<~MESSAGE.chomp
          幼稚園の入園試験で「この色わかる？」という質問に「レッ」と小声
          先生も母親もぽかーん😯
          どうやら好きだったレンジャーものに引きずられてレッドと言いたかったようです😂

          我が家は男兄弟だったので戦隊モノが好きだったんですね
          よくレンジャーショーに連れて行ってもらいました！
        MESSAGE
        asset_image = AssetImage.groom_child_news_ranger_image
        Line::PushMessage::ReplySimpleTextWithImageMessageService.new(event:, line_user:, message:, asset_image:, alt_text: event.message["text"]).call
      when RIGHT_MENU_MESSAGES[2]
        message = <<~MESSAGE.chomp
          昔から国語がとても苦手
          最初の挫折は漢字の読み方が二つ出てきたこと、、、
          テストに出てきたケンタくんの気持ちがなかなかわからない系男子でした😂
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when RIGHT_MENU_MESSAGES[3]
        message = <<~MESSAGE.chomp
          幼稚園生の時から水泳を習ってました
          中学に入る時に習い事の水泳はやめたのですが高校の部活動で再開！
          すごい速いわけではなかったのですが部内外での調整ごとが多くなり急遽部長になることに😓
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      when RIGHT_MENU_MESSAGES[4]
        message = <<~MESSAGE.chomp
          小さい頃から国語はすごい苦手だったのですがその逆で数学はだいぶ得意に
          大学受験は二次試験が数学しかないということで志望校を決定😂
          少し遠かったですが貴重な学生生活を送れました
        MESSAGE
        Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
      end
      # Line::PushMessage::ReplySimpleTextWithImageImageMessageService.new(event:, line_user:, asset_image:, message:, alt_text:).call
    end
  end
end
