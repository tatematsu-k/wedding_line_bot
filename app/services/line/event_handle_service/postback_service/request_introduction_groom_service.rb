# frozen_string_literal: true

module Line
  class EventHandleService::PostbackService::RequestIntroductionGroomService
    SERVICE_NAME = "request_introduction_groom"
    CMD_GREEN_TEA = "green_tea"
    CMD_TEA = "tea"
    CMD_COFFEE = "coffee"
    CMD_WINE = "wine"

    attr_reader :event, :line_user, :cmd

    def initialize(event:, line_user:, cmd:)
      @event = event
      @line_user = line_user
      @cmd = cmd
    end

    def call
      if line_user.question_status_wait_answer2?
        case cmd
        when CMD_GREEN_TEA
          message = <<~MESSAGE.chomp
            玄米茶が家にあるんですが淹れるの面倒であまり飲んでないんですよね...
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        when CMD_TEA
          message = <<~MESSAGE.chomp
            紅茶はよく新婦が飲んでます！
            新郎は時々もらうのですが飲み過ぎるとお腹が痛くなりがちで、、
            デザートとかの時に少しだけ飲んでます笑
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        when CMD_COFFEE
          message = <<~MESSAGE.chomp
            正解！
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        when CMD_WINE
          line_user.question_status_wait_answer2!
          message = <<~MESSAGE.chomp
            新婦家はよくワインを飲みます！
            が、、、、新郎家は全員下戸なんです笑
          MESSAGE
          Line::PushMessage::ReplySimpleTextMessageService.new(event:, line_user:, message:).call
        end
      end
    end
  end
end
