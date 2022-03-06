# == Schema Information
#
# Table name: invited_users
#
#  id           :bigint           not null, primary key
#  init_message :text(65535)      not null
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_invited_users_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :invited_user do
    sequence(:name) { |i| "name#{i}" }
    sequence(:init_message) { |i| "init_message#{i}" }
  end
end
