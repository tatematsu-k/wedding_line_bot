# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::AnswerQuestion1Service
    SERVICE_NAME = "answer_question1"
    CMD_HOKKAIDO = "hokkaido"
    CMD_KYOTO = "kyoto"
    CMD_OSAKA = "osaka"
    CMD_OKINAWA = "okinawas"

    attr_reader :event, :line_user, :cmd

    def initialize(event:, line_user:, cmd:)
      @event = event
      @line_user = line_user
      @cmd = cmd
    end

    def call
      if line_user.question_status_wait_answer1?
        case cmd
        when CMD_HOKKAIDO
          message = <<~MESSAGE.chomp
            北海道はいいですよね〜
            いつかお魚を食べに行きたいです
            おすすめの場所があったらぜひ教えてください！
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        when CMD_KYOTO
          message = <<~MESSAGE.chomp
            京都！
            まだ一緒に行けていないのですがいつか行ってみたい場所の一つです！
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        when CMD_OSAKA
          message = <<~MESSAGE.chomp
            大阪は二人で初めて行った旅行先です！
            謎解きをしたりUSJに行きました！
            またたこ焼き食べに行きたい！！
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        when CMD_OKINAWA
          line_user.question_status_wait_answer2!
          Line::PushMessage::SendQuestion2Service.new(event:, line_user:).call
        end
      end
    end
  end
end
