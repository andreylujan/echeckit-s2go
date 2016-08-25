# -*- encoding : utf-8 -*-
class RemoveBusinessWeekAndMonthFromWeeklyBusinessSales < ActiveRecord::Migration
  def change
    remove_column :weekly_business_sales, :business_week, :integer
    remove_column :weekly_business_sales, :month, :integer
  end
end
