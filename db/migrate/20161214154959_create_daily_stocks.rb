class CreateDailyStocks < ActiveRecord::Migration
  def change
    create_table :daily_stocks do |t|
      t.references :brand, index: true, foreign_key: true
      t.references :report, index: true, foreign_key: true
      t.integer :hardware_sales, null: false, default: 0, limit: 8
      t.integer :accessory_sales, null: false, default: 0, limit: 8
      t.integer :game_sales, null: false, default: 0, limit: 8

      t.timestamps null: false
    end
  end
end
