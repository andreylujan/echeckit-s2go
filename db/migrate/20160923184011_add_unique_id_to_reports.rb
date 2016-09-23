class AddUniqueIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :unique_id, :text
    add_index :reports, :unique_id
  end
end
