class AddReportUuidToImages < ActiveRecord::Migration
  def change
    add_column :images, :report_uuid, :text
    add_index :images, :report_uuid
  end
end
