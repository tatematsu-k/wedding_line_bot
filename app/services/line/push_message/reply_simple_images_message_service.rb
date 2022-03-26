# frozen_string_literal: true

class Line::PushMessage::ReplySimpleImagesMessageService
  attr_reader :event, :line_user, :asset_images

  def initialize(event:, line_user:, asset_images:)
    @event = event
    @line_user = line_user
    @asset_images = asset_images
  end

  def call
    line_client.reply_message(event["replyToken"], message_obj)
  end

  private
    def message_obj
      {
        type: "flex",
        altText: "画像です。スマートフォンで確認してください。",
        contents: {
          type: "carousel",
          contents:
            asset_images.map do |image|
              {
                type: "bubble",
                body: {
                  type: "box",
                  layout: "vertical",
                  contents: [
                    {
                      type: "image",
                      url: image.url,
                      size: "full",
                      action: {
                        type: "uri",
                        uri: image.url,
                      }
                    }
                  ]
                }
              }
            end
        }
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
