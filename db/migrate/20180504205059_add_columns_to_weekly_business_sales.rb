class AddColumnsToWeeklyBusinessSales < ActiveRecord::Migration
  def change
    add_column :weekly_business_sales, :category, :string , default: '', null:false
    add_column :weekly_business_sales, :goals_sales,:json, default: {} , null: false
      WeeklyBusinessSale.reset_column_information
      weeklys = WeeklyBusinessSale.all
      weeklys.each do |weekly|
        weekly.update_column :category, ''
        weekly.update_column :goals_sales, {}
      end
  end
end
