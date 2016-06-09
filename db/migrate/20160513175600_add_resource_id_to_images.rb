# -*- encoding : utf-8 -*-
class AddResourceIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :resource_id, :integer
    add_index :images, :resource_id
  end
end
