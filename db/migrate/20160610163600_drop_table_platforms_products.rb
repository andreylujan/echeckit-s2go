# -*- encoding : utf-8 -*-
class DropTablePlatformsProducts < ActiveRecord::Migration
  def change
  	drop_table :platforms_products
  end
end
