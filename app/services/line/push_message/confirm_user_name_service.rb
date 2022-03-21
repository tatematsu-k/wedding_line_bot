# frozen_string_literal: true

class Line::PushMessage::ConfirmUserNameService
  attr_reader :event, :line_user, :invited_user

  def initialize(event:, line_user:, invited_user:)
    @event = event
    @line_user = line_user
    @invited_user = invited_user
  end

  def call
    line_client.reply_message(event["replyToken"], confirm_message(invited_user))
  end

  private
    def confirm_message(invited_user)
      {
        type: "template",
        altText: "「#{invited_user.name}」さんでお間違いないですか？",
        template: {
          type: "confirm",
          text: "「#{invited_user.name}」さんでお間違いないですか？",
          actions: [
            {
              type: "postback",
              label: "はい",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::NameConfirmService::SERVICE_NAME,
                invited_user_id: invited_user.id,
                cmd: Line::EventHandleService::PostbackService::NameConfirmService::CMD_YES,
              ),
            },
            {
              type: "postback",
              label: "いいえ",
              data: URI.encode_www_form(
                service: Line::EventHandleService::PostbackService::NameConfirmService::SERVICE_NAME,
                invited_user_id: invited_user.id,
                cmd: Line::EventHandleService::PostbackService::NameConfirmService::CMD_NO,
              ),
            }
          ]
        }
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
