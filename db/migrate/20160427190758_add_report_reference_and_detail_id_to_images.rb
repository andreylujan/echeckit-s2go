class AddReportReferenceAndDetailIdToImages < ActiveRecord::Migration
  def change
    add_reference :images, :report, index: true, foreign_key: true
    add_column :images, :detail_id, :integer
  end
end
