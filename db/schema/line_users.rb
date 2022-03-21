# frozen_string_literal: true

create_table :line_users do |t|
  t.string :line_uid, null: false, index: { unique: true }
  t.string :follow_status, null: false
  t.string :question_status, null: false

  t.timestamps
end
