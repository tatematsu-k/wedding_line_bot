# frozen_string_literal: true

create_table :line_rich_menu_attaches do |t|
  t.references :line_user, null: false, index: { unique: true }, foreign_key: true
  t.references :line_rich_menu, null: false, index: { unique: false }, foreign_key: true

  t.timestamps
end
