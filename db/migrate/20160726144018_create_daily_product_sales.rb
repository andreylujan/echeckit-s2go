# -*- encoding : utf-8 -*-
class CreateDailyProductSales < ActiveRecord::Migration
  def change
    create_table :daily_product_sales do |t|
      t.references :product, index: true, foreign_key: true
      t.references :store, index: true, foreign_key: true
      t.datetime :sales_date, null: false
      t.integer :quantity, null: false
      t.integer :amount

      t.timestamps null: false
    end
  end
end
