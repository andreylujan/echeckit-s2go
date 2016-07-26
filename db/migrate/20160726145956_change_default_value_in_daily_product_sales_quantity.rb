class ChangeDefaultValueInDailyProductSalesQuantity < ActiveRecord::Migration
  def change
  	change_column :daily_product_sales, :quantity, :integer, null: false, default: 0
  	change_column :daily_product_sales, :amount, :integer, null: false, default: 0
  end
end
