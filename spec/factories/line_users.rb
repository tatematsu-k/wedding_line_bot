# frozen_string_literal: true

# == Schema Information
#
# Table name: line_users
#
#  id            :bigint           not null, primary key
#  follow_status :string(255)      not null
#  line_uid      :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_line_users_on_line_uid  (line_uid) UNIQUE
#
FactoryBot.define do
  factory :line_user do
    follow_status { "follow" }
    sequence(:line_uid) { |i| "lineUser#{i}" }
  end
end
