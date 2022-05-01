width = 2500
height = 843
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
          width: (width / 3),
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
          width: (width / 3),
          height: (height / 2)
        },
        action: {
          type: "message",
          text: Line::EventHandleService::MessageService::TextMessageService::RequestMenuService::MESSAGE
        }
      },
      {
        bounds: {
          x: (width / 3),
          y: (height / 2),
          width: (width / 3),
          height:
        },
        action: {
          type: "message",
          text: Line::EventHandleService::MessageService::TextMessageService::RequestIntroductionService::MESSAGE
        }
      },
      {
        bounds: {
          x: (width / 3),
          y: (height / 2),
          width: (width / 3),
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
