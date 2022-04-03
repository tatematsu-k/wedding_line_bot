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
  SEAT_IMAGE_KEY = "seat_image"
  MENU_KEY = "menu"
  MENU_JR_KEY = "menu_jr"
  FIRST_QUESTION_KEY = "first_question"
  SECOND_QUESTION_KEY = "second_question"

  def self.seat_list_image
    @@seat_list_image ||= AssetImage.find_by!(key: SEAT_IMAGE_KEY)
  end

  def self.menu_image
    @@menu_image ||= AssetImage.find_by!(key: MENU_KEY)
  end

  def self.menu_jr_image
    @@menu_jr_image ||= AssetImage.find_by!(key: MENU_JR_KEY)
  end

  def self.first_question_image
    @@first_question_image ||= AssetImage.find_by!(key: FIRST_QUESTION_KEY)
  end

  def self.second_question_image
    @@second_question_image ||= AssetImage.find_by!(key: SECOND_QUESTION_KEY)
  end
end
