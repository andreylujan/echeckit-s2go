class AddExecutorIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :executor_id, :integer
    add_index :reports, :executor_id
  end
end
