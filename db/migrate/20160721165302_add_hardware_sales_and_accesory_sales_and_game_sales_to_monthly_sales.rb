# -*- encoding : utf-8 -*-
class AddHardwareSalesAndAccesorySalesAndGameSalesToMonthlySales < ActiveRecord::Migration
  def change
    add_column :monthly_sales, :hardware_sales, :integer, null: false
    add_column :monthly_sales, :accesory_sales, :integer, null: false
    add_column :monthly_sales, :game_sales, :integer, null: false
  end
end
