class RemoveOrganizationReferenceFromPlatforms < ActiveRecord::Migration
  def change
  	remove_column :platforms, :organization_id
  end
end
