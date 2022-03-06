# frozen_string_literal: true

module Line
  class EventHandleService::FollowService
    attr_reader :event, :line_user, :refollow_flg

    def initialize(event:, line_user:)
      @event = event
      @line_user = line_user
      @refollow_flg = line_user.unfollow?
    end

    def call
      line_user.follow!

      if refollow_flg
        # 復帰
      else
        # 初回登録
        PushMessage::FirstFollowService.new(
          event:,
          line_user:,
        ).call
      end
    end
  end
end
