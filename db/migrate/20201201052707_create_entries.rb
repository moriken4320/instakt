class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :user, null: :false, foreign_key: true, index: {unique: true}
      t.references :recruit, null: :false, foreign_key: true
      t.timestamps
    end
  end
end
