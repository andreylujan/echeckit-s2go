# -*- encoding : utf-8 -*-
class CreateWeeklyBusinessSales < ActiveRecord::Migration
  def change
    create_table :weekly_business_sales do |t|
      t.references :store, index: true, foreign_key: true, null: false
      t.integer :business_week, null: false
      t.integer :month, null: false
      t.integer :hardware_sales, null: false, default: 0, limit: 8
      t.integer :accessory_sales, null: false, default: 0, limit: 8
      t.integer :game_sales, null: false, default: 0, limit: 8

      t.timestamps null: false
    end
  end
end
