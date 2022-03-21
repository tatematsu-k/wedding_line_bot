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

  enum follow_status: {
    follow: "follow",
    unfollow: "unfollow"
  }, _default: "follow"

  enum question_status: {
    not_started: "not_started",
    wait_answer1: "wait_answer1"
  }, _default: "not_started", _prefix: true
end
