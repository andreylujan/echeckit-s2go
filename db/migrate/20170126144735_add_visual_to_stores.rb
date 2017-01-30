class AddVisualToStores < ActiveRecord::Migration
  def change
    add_column :stores, :visual, :text, null: true
  end
end
