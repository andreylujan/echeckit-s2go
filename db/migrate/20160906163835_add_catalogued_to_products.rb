# -*- encoding : utf-8 -*-
class AddCataloguedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :catalogued, :boolean, null: false, default: true
    add_index :products, :catalogued
  end
end
