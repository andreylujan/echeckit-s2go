# -*- encoding : utf-8 -*-
class CreateStoreTypes < ActiveRecord::Migration
  def change
    create_table :store_types do |t|
      t.text :name, null: false

      t.timestamps null: false
    end
    add_index :store_types, :name, unique: true
  end
end
