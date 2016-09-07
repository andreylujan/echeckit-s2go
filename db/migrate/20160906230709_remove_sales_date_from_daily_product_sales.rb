# -*- encoding : utf-8 -*-
class RemoveSalesDateFromDailyProductSales < ActiveRecord::Migration
  def change
    remove_column :daily_product_sales, :sales_date, :datetime
  end
end
