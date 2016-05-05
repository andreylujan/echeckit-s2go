class AddUuidToReports < ActiveRecord::Migration
  def change
    add_column :reports, :uuid, :text
    add_index :reports, :uuid
  end
end
