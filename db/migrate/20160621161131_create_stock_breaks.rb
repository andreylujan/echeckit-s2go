# -*- encoding : utf-8 -*-
class CreateStockBreaks < ActiveRecord::Migration
  def change
    create_table :stock_breaks do |t|
      t.references :dealer, index: true, foreign_key: true
      t.references :store_type, index: true, foreign_key: true
      t.references :product_classification, index: true, foreign_key: true
      t.integer :stock_break

      t.timestamps null: false
    end
  end
end
