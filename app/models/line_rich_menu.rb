# frozen_string_literal: true

# == Schema Information
#
# Table name: line_rich_menus
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  rich_menu_id :string(255)      not null
#
class LineRichMenu < ApplicationRecord
  has_many :line_rich_menu_attaches
end
