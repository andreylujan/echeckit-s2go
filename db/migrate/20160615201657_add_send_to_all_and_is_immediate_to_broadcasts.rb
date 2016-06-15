class AddSendToAllAndIsImmediateToBroadcasts < ActiveRecord::Migration
  def change
    add_column :broadcasts, :send_to_all, :boolean, null: false, default: false
    add_column :broadcasts, :is_immediate, :boolean, null: false, default: false
  end
end
