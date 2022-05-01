# frozen_string_literal: true

class Line::PushMessage::BrideJobService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    Line::PushMessage::ReplySimpleImageMessageService.new(event:, line_user:, asset_image:).call
  end

  private
    def asset_image
      AssetImage.bride_job_image
    end
end
