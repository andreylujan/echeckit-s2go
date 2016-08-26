# -*- encoding : utf-8 -*-
class AddDeletedAtToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :deleted_at, :datetime
    add_index :broadcasts, :deleted_at
  end
end
