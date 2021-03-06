# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::CheckUserNameService
    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      invited_user = find_invited_user

      PushMessage::ConfirmUserNameService.new(event:, line_user:, invited_user:).call
    rescue ActiveRecord::RecordNotFound
      message = <<~MESSAGE.chomp
        申し訳ございません。
        お名前の確認に失敗しました。
        お手数ですが再度お名前の入力をお願いします。
      MESSAGE
      Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
    end

    private
      def find_invited_user
        # まずは完全一致で確認
        @invited_user ||= InvitedUser.find_by(name: trimed_inputed_name)
        return @invited_user if @invited_user

        # 部分一致で検索してみる(苗字だけでもある程度反応するように)
        candidates = InvitedUser.where("name like ?", "%#{trimed_inputed_name}%")
        if candidates.count == 1
          @invited_user = candidates.last
          return @invited_user
        end

        raise ActiveRecord::RecordNotFound
      end

      def trimed_inputed_name
        @trimed_inputed_name ||= event.message["text"].gsub(/[[:space:]]/, "")
      end
  end
end
