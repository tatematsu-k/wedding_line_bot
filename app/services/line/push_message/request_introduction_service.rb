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
            ),
            column(
              asset_image: AssetImage.bride1_image,
              name: "五反田梓",
              message: "今日一日楽しんで行ってくれたら嬉しいです",
              is_broom: false,
            )
          ],
          imageAspectRatio: "rectangle",
          imageSize: "cover"
        }
      }
    end

    def column(asset_image:, name:, message:, is_broom:)
      receive_service_class = receive_service_class(is_broom:)

      {
        thumbnailImageUrl: asset_image.url,
        imageBackgroundColor: "#FFFFFF",
        title: "#{is_broom ? "新郎" : "新婦"}:  #{name}",
        text: message,
        actions: [
          {
            type: "postback",
            label: "子ども時代について",
            data: URI.encode_www_form(
              service: receive_service_class::SERVICE_NAME,
              cmd: receive_service_class::CMD_ABOUT_CHILD,
            ),
          },
          {
            type: "postback",
            label: "仕事について",
            data: URI.encode_www_form(
              service: receive_service_class::SERVICE_NAME,
              cmd: receive_service_class::CMD_ABOUT_JOB,
            ),
          },
          {
            type: "postback",
            label: "趣味について",
            data: URI.encode_www_form(
              service: receive_service_class::SERVICE_NAME,
              cmd: receive_service_class::CMD_ABOUT_HOBBY,
            ),
          },
        ]
      }
    end

    def receive_service_class(is_broom:)
      is_broom ? Line::EventHandleService::PostbackService::RequestIntroductionGroomService : Line::EventHandleService::PostbackService::RequestIntroductionBrideService
    end

    def line_client
      @line_client ||= LineClient.build
    end
end
