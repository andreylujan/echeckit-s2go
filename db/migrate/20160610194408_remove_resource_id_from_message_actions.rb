# -*- encoding : utf-8 -*-
class RemoveResourceIdFromMessageActions < ActiveRecord::Migration
  def change
    remove_column :message_actions, :resource_id, :integer
  end
end
