class AddPdfUploadedToReports < ActiveRecord::Migration
  def change
    add_column :reports, :pdf_uploaded, :boolean, default: false, null: false
  end
end
