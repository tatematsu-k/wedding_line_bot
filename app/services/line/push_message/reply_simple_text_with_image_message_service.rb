# frozen_string_literal: true

class Line::PushMessage::ReplySimpleTextWithImageMessageService
  attr_reader :event, :line_user, :asset_image, :message, :alt_text

  def initialize(event:, line_user:, asset_image:, message:, alt_text:)
    @event = event
    @line_user = line_user
    @asset_image = asset_image
    @message = message
    @alt_text = alt_text
  end

  def call
    line_client.reply_message(event["replyToken"], message_obj)
  end

  private
    def message_obj
      {
        type: "flex",
        altText: alt_text,
        contents: {
          type: "bubble",
          hero: {
            type: "image",
            url: asset_image.url,
            size: "full",
            aspectMode: "cover"
          },
          body: {
            type: "box",
            layout: "vertical",
            contents: [
              {
                type: "box",
                layout: "vertical",
                spacing: "sm",
                margin: "xs",
                contents: [
                  {
                    type: "text",
                    text: message,
                    wrap: true,
                  }
                ]
              }
            ]
          }
        }
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
