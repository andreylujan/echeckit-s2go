# -*- encoding : utf-8 -*-
class AddResourceTypeToImages < ActiveRecord::Migration
  def change
    add_column :images, :resource_type, :text
    add_index :images, :resource_type
  end
end
