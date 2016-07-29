# -*- encoding : utf-8 -*-
class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.text :name, null: false

      t.timestamps null: false
    end
    add_index :brands, :name, unique: true
  end
end
