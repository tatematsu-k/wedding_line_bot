# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::RequestSeatListService
    MESSAGE="披露宴の座席は？".freeze

    attr_reader :event, :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      PushMessage::ReplySimpleImageMessageService.new(event:, line_user:, asset_image:).call
    end

    private
      def asset_image
        AssetImage.seat_list_image
      end
  end
end
