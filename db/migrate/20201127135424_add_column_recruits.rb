class AddColumnRecruits < ActiveRecord::Migration[6.0]
  def change
    add_column :recruits, :close_flag, :boolean, default: false, null: false
  end
end
