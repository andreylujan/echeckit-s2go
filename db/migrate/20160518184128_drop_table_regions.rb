# -*- encoding : utf-8 -*-
class DropTableRegions < ActiveRecord::Migration
  def change
  	drop_table :regions
  end
end
