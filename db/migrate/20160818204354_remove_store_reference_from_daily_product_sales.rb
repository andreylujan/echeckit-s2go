class RemoveStoreReferenceFromDailyProductSales < ActiveRecord::Migration
  def change
    remove_reference :daily_product_sales, :store, index: true, foreign_key: true
  end
end
