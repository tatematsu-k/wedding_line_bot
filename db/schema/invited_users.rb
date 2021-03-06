# frozen_string_literal: true

create_table :invited_users do |t|
  t.string :name, null: false, index: { unique: true }
  t.text :init_message, null: false

  t.boolean :send_junior_menu, null: false, default: false
  t.timestamps
end
