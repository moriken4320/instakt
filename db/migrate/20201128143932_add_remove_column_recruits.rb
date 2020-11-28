class AddRemoveColumnRecruits < ActiveRecord::Migration[6.0]
  def change
    add_column :recruits, :close_condition_count, :integer, null: false
    remove_column :laters, :close_condition_count, :integer
    remove_column :nows, :close_condition_count, :integer
  end
end
