class DestroyTableMonthlySale < ActiveRecord::Migration
  def change
  	drop_table :monthly_sales
  end
end