create_table :invited_users do |t|
  t.string :name, null: false, index: { unique: true }

  t.timestamps
end
