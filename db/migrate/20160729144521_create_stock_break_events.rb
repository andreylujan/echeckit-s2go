# -*- encoding : utf-8 -*-
class CreateStockBreakEvents < ActiveRecord::Migration
  def change
    create_table :stock_break_events do |t|
      t.references :store, index: true, foreign_key: true, null: false
      t.references :product, index: true, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.datetime :stock_break_date, null: false

      t.timestamps null: false
    end
  end
end
