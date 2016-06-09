# -*- encoding : utf-8 -*-
class RemoveOrganizationReferenceFromPlatforms < ActiveRecord::Migration
  def change
  	remove_column :platforms, :organization_id
  end
end
