# frozen_string_literal: true

create_table :asset_images do |t|
  t.string :key, null: false
  t.string :url, null: false

  t.timestamps
end
