# frozen_string_literal: true

class Line::PushMessage::ReplySimpleImageMessageService
  attr_reader :event, :line_user, :asset_image

  def initialize(event:, line_user:, asset_image:)
    @event = event
    @line_user = line_user
    @asset_image = asset_image
  end

  def call
    line_client.reply_message(event["replyToken"], message_obj)
  end

  private
    def message_obj
      {
        type: "image",
        originalContentUrl: asset_image.url,
        previewImageUrl: asset_image.url,
      }
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
