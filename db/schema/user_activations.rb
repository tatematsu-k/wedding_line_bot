# frozen_string_literal: true

create_table :user_activations do |t|
  t.references :invited_user, null: false, index: { unique: true }, foreign_key: true
  t.references :line_user, null: false, index: { unique: true }, foreign_key: true

  t.timestamps
end
