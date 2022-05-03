# frozen_string_literal: true

width = 2500
height = 843
side_menu_width = 600
main_menu_width = (width - side_menu_width) / 2
line_client = LineClient.build
res = line_client.create_rich_menu(
  {
    size: {
      width:,
      height:
    },
    selected: true,
    name: "wedding rich menu",
    chatBarText: "メニュー",
    areas: [
      {
        bounds: {
          x: 0,
          y: 0,
          width: side_menu_width,
          height: (height / 2)
        },
        action: {
          type: "message",
          text: Line::EventHandleService::MessageService::TextMessageService::RequestSeatListService::MESSAGE
        }
      },
      {
        bounds: {
          x: 0,
          y: (height / 2),
          width: side_menu_width,
          height: (height / 2)
        },
        action: {
          type: "message",
          text: Line::EventHandleService::MessageService::TextMessageService::RequestMenuService::MESSAGE
        }
      },
      {
        bounds: {
          x: side_menu_width,
          y: 0,
          width: main_menu_width,
          height:
        },
        action: {
          type: "message",
          text: Line::EventHandleService::MessageService::TextMessageService::RequestIntroductionService::MESSAGE
        }
      },
      {
        bounds: {
          x: side_menu_width + main_menu_width,
          y: 0,
          width: main_menu_width,
          height:
        },
        action: {
          type: "message",
          text: Line::EventHandleService::MessageService::TextMessageService::ClickStartQuestionService::MESSAGE
        }
      }
    ]
  }
)
parsed_res = JSON.parse(res.body)
line_client.create_rich_menu_image(parsed_res["richMenuId"], URI.open(AssetImage.rich_menu_image.url))
LineRichMenu.create!(rich_menu_id: parsed_res["richMenuId"])
LineUser.joins(:user_activation).each(&:attach_latest_line_rich_menu!)
