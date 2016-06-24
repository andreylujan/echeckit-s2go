class AddCodeToStores < ActiveRecord::Migration
  def change
    add_column :stores, :code, :text
  end
end
