# frozen_string_literal: true

class Line::PushMessage::BrideHobbyService
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
        AssetImage.bride_hobby1_image,
        AssetImage.bride_hobby2_image,
      ]
    end
end
