# frozen_string_literal: true

class Line::PushMessage::GroomChildService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], message)
  end

  FULL_WIDTH = 1040
  LEFT_MENU_WIDTH = 355
  LEFT_MENU_HEIGHT = 320
  RIGHT_MENU_WIDTH = FULL_WIDTH - LEFT_MENU_WIDTH
  RIGHT_MENU_HEIGHT = (LEFT_MENU_HEIGHT * 2 / 5).to_i
  private
    def message
      {
        type: "imagemap",
        baseUrl: AssetImage.groom_child_news_image.url,
        altText: "新郎の子ども時代",
        baseSize: {
          width: FULL_WIDTH,
          height: 1343
        },
        actions: [
          {
            type: "message",
            area: {
              x: 0,
              y: 83,
              width: FULL_WIDTH,
              height: 618
            },
            text: Line::EventHandleService::MessageService::TextMessageService::GroomChildNewsReceiveService::TOP_MENU_MESSAGE
          },
          *left_menus,
          *right_menus
        ]
      }
    end

    def left_menus
      Line::EventHandleService::MessageService::TextMessageService::GroomChildNewsReceiveService::LEFT_MENU_MESSAGES.map.with_index do |text, i|
        {
          type: "message",
          area: {
            x: 0,
            y: 701 + LEFT_MENU_HEIGHT * i,
            width: LEFT_MENU_WIDTH,
            height: LEFT_MENU_HEIGHT
          },
          text:
        }
      end
    end

    def right_menus
      Line::EventHandleService::MessageService::TextMessageService::GroomChildNewsReceiveService::RIGHT_MENU_MESSAGES.map.with_index do |text, i|
        {
          type: "message",
          area: {
            x: LEFT_MENU_WIDTH,
            y: 701 + RIGHT_MENU_HEIGHT * i,
            width: RIGHT_MENU_WIDTH,
            height: RIGHT_MENU_HEIGHT
          },
          text:
        }
      end
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
