class AddWeekNumberToWeeklyBusinessSales < ActiveRecord::Migration
  def change
    add_column :weekly_business_sales, :week_number, :integer
    WeeklyBusinessSale.all.each do |weekly_sale|
    	weekly_sale.week_number = weekly_sale.week_start.cweek
    	weekly_sale.save!
    end
    change_column :weekly_business_sales, :week_number, :integer, null: false
  end
end
