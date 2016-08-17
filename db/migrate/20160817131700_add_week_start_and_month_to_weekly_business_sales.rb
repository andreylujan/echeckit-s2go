class AddWeekStartAndMonthToWeeklyBusinessSales < ActiveRecord::Migration
  def change
    add_column :weekly_business_sales, :week_start, :date
    add_column :weekly_business_sales, :month, :date
  end
end
