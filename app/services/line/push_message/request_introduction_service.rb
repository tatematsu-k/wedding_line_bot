# frozen_string_literal: true

class Line::PushMessage::RequestIntroductionService
  attr_reader :event, :line_user

  def initialize(event:, line_user:)
    @event = event
    @line_user = line_user
  end

  def call
    line_client.reply_message(event["replyToken"], message)
  end

  private
    def message
      {
        type: "template",
        altText: "新郎新婦について",
        template: {
          type: "carousel",
          columns: [
            column(
              asset_image: AssetImage.groom1_image,
              name: "立松幸樹",
              message: "みなさんと一緒にこの日を過ごせて幸せです",
              is_broom: true,
            )
            {
              thumbnailImageUrl: AssetImage.groom1_image.url,
              imageBackgroundColor: "#FFFFFF",
              title: "新郎: 立松幸樹",
              text: "みなさんと一緒にこの日を過ごせて幸せです",
              actions: [
                {
                  type: "postback",
                  label: "Buy",
                  data: "action=buy&itemid=111"
                },
                {
                  type: "postback",
                  label: "Add to cart",
                  data: "action=add&itemid=111"
                },
                {
                  type: "uri",
                  label: "View detail",
                  uri: "http://example.com/page/111"
                }
              ]
            },
            {
              thumbnailImageUrl: AssetImage.bride1_image.url,
              imageBackgroundColor: "#000000",
              title: "新婦: 五反田梓",
              text: "あずさからのメッセージ？",
              defaultAction: {
                type: "uri",
                label: "View detail",
                uri: "http://example.com/page/222"
              },
              actions: [
                {
                  type: "postback",
                  label: "Buy",
                  data: "action=buy&itemid=222"
                },
                {
                  type: "postback",
                  label: "Add to cart",
                  data: "action=add&itemid=222"
                },
                {
                  type: "uri",
                  label: "View detail",
                  uri: "http://example.com/page/222"
                }
              ]
            }
          ],
          imageAspectRatio: "rectangle",
          imageSize: "cover"
        }
      }
    end

    def column(asset_image:, name:, message:, is_broom:)
      {
        thumbnailImageUrl: asset_image.url,
        imageBackgroundColor: "#FFFFFF",
        title: "#{is_broom ? "新郎" : "新婦"}:  #{name}",
        text: message,
        actions: [
          {
            type: "postback",
            label: "Buy",
            data: "action=buy&itemid=111"
          },
          {
            type: "postback",
            label: "Add to cart",
            data: "action=add&itemid=111"
          },
          {
            type: "uri",
            label: "View detail",
            uri: "http://example.com/page/111"
          }
        ]
      }
    end

    def receive_service(is_broom:)
      is_broom ? EventHandleService::PostbackService::RequestIntroductionGroomService : EventHandleService::PostbackService::RequestIntroductionBrideService
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
