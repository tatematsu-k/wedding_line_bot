# frozen_string_literal: true

# == Schema Information
#
# Table name: invited_users
#
#  id               :bigint           not null, primary key
#  init_message     :text(65535)      not null
#  name             :string(255)      not null
#  send_junior_menu :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_invited_users_on_name  (name) UNIQUE
#
class InvitedUser < ApplicationRecord
  has_one :user_activation, dependent: :destroy
  delegate :line_user, to: :user_activation, allow_nil: true
end
