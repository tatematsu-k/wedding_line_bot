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
  GROOM1_KEY = "groom1"
  BRIDE1_KEY = "bride1"
  GROOM_CHILD_NEWS_KEY = "groom_child_key"
  BRIDE_CHILD_NEWS_KEY = "bride_child_key"
  BRIDE_CHILD_NEWS_SWIM_KEY = "bride_child_swim_key"
  BRIDE_CHILD_NEWS_MOCHI_KEY = "bride_child_mochi_key"
  BRIDE_CHILD_NEWS_ALCHOL_KEY = "bride_child_alchol_key"
  BRIDE_CHILD_NEWS_NOODLE_KEY = "bride_child_noodle_key"
  GROOM_CHILD_NEWS_RANGER_KEY = "groom_child_ranger_key"
  GROOM_CHILD_NEWS_AIKIDO_KEY = "groom_child_aikido_key"
  GROOM_HOBBY1_KEY = "groom_hoby1"
  GROOM_HOBBY2_KEY = "groom_hoby2"
  BRIDE_HOBBY1_KEY = "bride_hoby1"
  BRIDE_HOBBY2_KEY = "bride_hoby2"

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

  def self.groom1_image
    @@groom1_image ||= AssetImage.find_by!(key: GROOM1_KEY)
  end

  def self.bride1_image
    @@bride1_image ||= AssetImage.find_by!(key: BRIDE1_KEY)
  end

  def self.groom_child_news_image
    @@groom_child_news_image ||= AssetImage.find_by!(key: GROOM_CHILD_NEWS_KEY)
  end

  def self.bride_child_news_image
    @@bride_child_news_image ||= AssetImage.find_by!(key: BRIDE_CHILD_NEWS_KEY)
  end

  def self.bride_child_news_swim_image
    @@bride_child_news_swim_image ||= AssetImage.find_by!(key: BRIDE_CHILD_NEWS_SWIM_KEY)
  end

  def self.bride_child_news_mochi_image
    @@bride_child_news_mochi_image ||= AssetImage.find_by!(key: BRIDE_CHILD_NEWS_MOCHI_KEY)
  end

  def self.bride_child_news_alchol_image
    @@bride_child_news_alchol_image ||= AssetImage.find_by!(key: BRIDE_CHILD_NEWS_ALCHOL_KEY)
  end

  def self.bride_child_news_noodle_image
    @@bride_child_news_noodle_image ||= AssetImage.find_by!(key: BRIDE_CHILD_NEWS_NOODLE_KEY)
  end

  def self.groom_child_news_ranger_image
    @@groom_child_news_ranger_image ||= AssetImage.find_by!(key: GROOM_CHILD_NEWS_RANGER_KEY)
  end

  def self.groom_child_news_aikido_image
    @@groom_child_news_aikido_image ||= AssetImage.find_by!(key: GROOM_CHILD_NEWS_AIKIDO_KEY)
  end

  def self.groom_hobby1_image
    @@groom_hobby1_image ||= AssetImage.find_by!(key: GROOM_HOBBY1_KEY)
  end

  def self.groom_hobby2_image
    @@groom_hobby2_image ||= AssetImage.find_by!(key: GROOM_HOBBY2_KEY)
  end

  def self.bride_hobby1_image
    @@bride_hobby1_image ||= AssetImage.find_by!(key: BRIDE_HOBBY1_KEY)
  end

  def self.bride_hobby2_image
    @@bride_hobby2_image ||= AssetImage.find_by!(key: BRIDE_HOBBY2_KEY)
  end
end
