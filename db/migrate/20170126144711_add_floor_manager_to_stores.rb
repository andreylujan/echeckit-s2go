class AddFloorManagerToStores < ActiveRecord::Migration
  def change
    add_column :stores, :floor_manager, :text, null: true
  end
end
