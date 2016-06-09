# -*- encoding : utf-8 -*-
class RemoveAttributesFromStores < ActiveRecord::Migration
  def change
  	remove_column :stores, :zone_id
  	remove_column :stores, :dealer_id
  end
end
