class CreateNows < ActiveRecord::Migration[6.0]
  def change
    create_table :nows do |t|
      t.integer :member_count, null: :false
      t.string :end_at_hour_top, null: :false
      t.string :end_at_minute_top, null: :false
      t.string :end_at_hour_bottom, null: :false
      t.string :end_at_minute_bottom, null: :false
      t.string :place
      t.string :message
      t.references :recruit, null: :false, foreign_key: true
      t.timestamps
    end
  end
end
