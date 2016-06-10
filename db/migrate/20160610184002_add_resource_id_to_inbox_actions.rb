# -*- encoding : utf-8 -*-
class AddResourceIdToInboxActions < ActiveRecord::Migration
  def change
    add_column :inbox_actions, :resource_id, :integer
    add_index :inbox_actions, :resource_id
  end
end
