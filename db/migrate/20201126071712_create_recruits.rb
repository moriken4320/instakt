class CreateRecruits < ActiveRecord::Migration[6.0]
  def change
    create_table :recruits do |t|
      t.references :user, null: :false, foreign_key: true, index: {unique: true}
      t.boolean :close_flag, default: false, null: false
      t.integer :close_condition_count, null: false
      t.timestamps
    end
  end
end
