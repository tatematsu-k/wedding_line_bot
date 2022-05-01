# frozen_string_literal: true

# == Schema Information
#
# Table name: line_users
#
#  id              :bigint           not null, primary key
#  follow_status   :string(255)      not null
#  line_uid        :string(255)      not null
#  question_status :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_line_users_on_line_uid  (line_uid) UNIQUE
#
class LineUser < ApplicationRecord
  has_one :user_activation, dependent: :destroy
  has_one :invited_user, through: :user_activation
  has_one :line_rich_menu_attach, dependent: :destroy

  enum follow_status: {
    follow: "follow",
    unfollow: "unfollow"
  }, _default: "follow"

  enum question_status: {
    not_started: "not_started",
    wait_answer1: "wait_answer1",
    wait_answer2: "wait_answer2"
  }, _default: "not_started", _prefix: true

  def activate!(invited_user:)
    transaction do
      create_user_activation!(invited_user:)
      attach_latest_line_rich_menu!
    end
  end

  private

  def attach_latest_line_rich_menu!
    line_rich_menu = LineRichMenu.last
    # cf: https://developers.line.biz/ja/docs/messaging-api/using-rich-menus/#when-setting-change-takes-effect
    # 即時反映にするために一回unlinkしてからlinkし直す
    line_client.unlink_user_rich_menu(line_uid)
    line_client.link_user_rich_menu(line_uid, line_rich_menu.rich_menu_id)
    line_rich_menu_attach.present? ? line_rich_menu_attach.update!(line_rich_menu:) : create_line_rich_menu_attach!(line_rich_menu:)
  end

  def line_client
    @line_client ||= LineClient.build
  end
end
