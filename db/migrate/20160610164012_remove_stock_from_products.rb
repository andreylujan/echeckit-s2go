class RemoveStockFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :stock, :integer
  end
end
