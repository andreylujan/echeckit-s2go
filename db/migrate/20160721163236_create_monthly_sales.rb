# -*- encoding : utf-8 -*-
class CreateMonthlySales < ActiveRecord::Migration
  def change
    create_table :monthly_sales do |t|
      t.references :store, index: true, foreign_key: true, null: false
      t.integer :amount, null: false
      t.datetime :sales_date, null: false

      t.timestamps null: false
    end
  end
end
