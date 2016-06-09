# -*- encoding : utf-8 -*-
class RemoveRegionIdFromZones < ActiveRecord::Migration
  def change
    remove_column :zones, :region_id, :integer
  end
end
