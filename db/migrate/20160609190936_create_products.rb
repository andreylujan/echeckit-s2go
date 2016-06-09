class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :name, null: false
      t.text :description
      t.text :sku
      t.text :plu
      t.text :validity_code
      t.references :product_type, null: false, index: true, foreign_key: true
      t.text :brand
      t.integer :min_price
      t.integer :max_price
      t.integer :stock
      t.references :product_destination, null: false, index: true, foreign_key: true
      t.boolean :is_top, null: false, default: false
      t.boolean :is_listed, null: false, default: false

      t.timestamps null: false
    end
    add_index :products, :sku, unique: true
    add_index :products, :plu, unique: true
    add_index :products, :is_listed
  end
end
