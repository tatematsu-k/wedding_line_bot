# frozen_string_literal: true

class Line::PushMessage::GroomHobbyService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    Line::PushMessage::ReplySimpleImagesMessageService.new(event:, line_user:, asset_images:).call
  end

  private
    def asset_images
      [
        AssetImage.groom_hobby1_image,
        AssetImage.groom_hobby2_image,
      ]
    end
end
