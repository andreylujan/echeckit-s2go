# -*- encoding : utf-8 -*-
class AddIndexOnProductsName < ActiveRecord::Migration
  def change
  	add_index :products, :name
  end
end
