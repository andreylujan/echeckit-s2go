# -*- encoding : utf-8 -*-
class ChangeSalesAmountDefaultsInMonthlySales < ActiveRecord::Migration
  def change
  	rename_column :monthly_sales, :accesory_sales, :accessory_sales
  	change_column :monthly_sales, :hardware_sales, :integer, null: false, default: 0
  	change_column :monthly_sales, :accessory_sales, :integer, null: false, default: 0
  	change_column :monthly_sales, :game_sales, :integer, null: false, default: 0
  end
end
