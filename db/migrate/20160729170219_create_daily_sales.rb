class CreateDailySales < ActiveRecord::Migration
  def change
    create_table :daily_sales do |t|
      t.references :store, index: true, foreign_key: true, null: false
      t.references :brand, index: true, foreign_key: true, null: false
      t.datetime :sales_date, null: false
      t.integer :hardware_sales, null: false, default: 0
      t.integer :accessory_sales, null: false, default: 0
      t.integer :game_sales, null: false, default: 0

      t.timestamps null: false
    end
  end
end
