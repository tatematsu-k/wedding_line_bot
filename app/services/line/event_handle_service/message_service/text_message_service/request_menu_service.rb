# frozen_string_literal: true

module Line
  class EventHandleService::MessageService::TextMessageService::RequestMenuService
    MESSAGE = "お食事のメニュー"

    attr_reader :event, :line_user

    delegate :invited_user, to: :line_user

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
    end

    def call
      if invited_user.send_junior_menu
        PushMessage::ReplySimpleImagesMessageService.new(event:, line_user:, asset_images: [menu_image, menu_jr_image]).call
      else
        PushMessage::ReplySimpleImageMessageService.new(event:, line_user:, asset_image: menu_image).call
      end
    end

    private
      def menu_image
        AssetImage.menu_image
      end

      def menu_jr_image
        AssetImage.menu_jr_image
      end
  end
end
