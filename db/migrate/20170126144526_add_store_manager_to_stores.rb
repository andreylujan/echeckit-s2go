class AddStoreManagerToStores < ActiveRecord::Migration
  def change
    add_column :stores, :store_manager, :text, null: true
  end
end
