class AddResourceIdToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :resource_id, :integer
  end
end
