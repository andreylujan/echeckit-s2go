class AddDeletedAtToWeeklyBusinessSales < ActiveRecord::Migration
  def change
    add_column :weekly_business_sales, :deleted_at, :datetime
    add_index :weekly_business_sales, :deleted_at
  end
end
