# frozen_string_literal: true

# == Schema Information
#
# Table name: line_rich_menu_attaches
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  line_rich_menu_id :bigint           not null
#  line_user_id      :bigint           not null
#
# Indexes
#
#  index_line_rich_menu_attaches_on_line_rich_menu_id  (line_rich_menu_id)
#  index_line_rich_menu_attaches_on_line_user_id       (line_user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (line_rich_menu_id => line_rich_menus.id)
#  fk_rails_...  (line_user_id => line_users.id)
#
class LineRichMenuAttach < ApplicationRecord
  belongs_to :line_rich_menu
  belongs_to :line_user
end
