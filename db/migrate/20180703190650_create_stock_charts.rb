class CreateStockCharts < ActiveRecord::Migration
  def change
    create_table :stock_charts do |t|
      t.string :dealer
      t.string :stock_category
      t.string :store_code
      t.string :store_name
      t.string :week
      t.string :year
      t.string :month
      t.string :unit_stock
      t.datetime :deleted_at
      t.integer :store_id
      t.datetime :created_at
      t.datetime :updated_at
      t.datetime :stock_date
    end
  end
end
