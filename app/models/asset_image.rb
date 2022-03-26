# frozen_string_literal: true

# == Schema Information
#
# Table name: asset_images
#
#  id         :bigint           not null, primary key
#  key        :string(255)      not null
#  url        :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AssetImage < ApplicationRecord
  SEAT_IMAGE_KEY = "seat_image".freeze
  FIRST_QUESTION = "first_question".freeze

  def self.seat_list_image
    @@seat_list_image ||= AssetImage.find_by!(key: SEAT_IMAGE_KEY)
  end

  def self.first_question_image
    @@first_question_image ||= AssetImage.find_by!(key: FIRST_QUESTION)
  end
end
