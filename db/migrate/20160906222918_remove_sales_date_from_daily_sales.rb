# -*- encoding : utf-8 -*-
class RemoveSalesDateFromDailySales < ActiveRecord::Migration
  def change
    remove_column :daily_sales, :sales_date, :datetime
  end
end
