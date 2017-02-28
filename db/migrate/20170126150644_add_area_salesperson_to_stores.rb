class AddAreaSalespersonToStores < ActiveRecord::Migration
  def change
    add_column :stores, :area_salesperson, :text, null: true
  end
end
