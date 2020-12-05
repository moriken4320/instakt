class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text, null: :false
      t.integer :sender_id, null: :false
      t.integer :room_id, null: :false
      t.timestamps
    end
    add_index :messages, :sender_id, unique: true
    add_index :messages, :room_id
    add_index :messages, [:sender_id, :room_id], unique: true
  end
end
