class AddColumnsToBroadcast < ActiveRecord::Migration
  def change
    add_column :broadcasts, :dealers, :json, default: nil , null: true
    add_column :broadcasts, :stores, :json, default: nil , null: true
  end
end
