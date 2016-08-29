class RemoveOrganizationIdFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :organization_id, :integer
  end
end
