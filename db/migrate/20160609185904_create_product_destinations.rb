# -*- encoding : utf-8 -*-
class CreateProductDestinations < ActiveRecord::Migration
  def change
    create_table :product_destinations do |t|
      t.text :name, null: false
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :product_destinations, [ :organization_id, :name ], unique: true
  end
end
