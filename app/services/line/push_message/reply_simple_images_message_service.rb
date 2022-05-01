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
        altText: "画像が届きました",
        contents: {
          type: "carousel",
          contents:
            asset_images.map do |image|
              mini_magick_image = MiniMagick::Image.open(image.url)

              {
                type: "bubble",
                hero: {
                  type: "image",
                  url: image.url,
                  size: "full",
                  aspectRatio: "#{mini_magick_image[:width]}:#{mini_magick_image[:height]}",
                  aspectMode: "cover",
                  action: {
                    type: "uri",
                    uri: image.url,
                  }
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
