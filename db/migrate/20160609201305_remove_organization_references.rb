class RemoveOrganizationReferences < ActiveRecord::Migration
  def change
  	remove_column :product_types, :organization_id
  	remove_column :product_destinations, :organization_id
  end
end
