# -*- encoding : utf-8 -*-
class CreateJoinTablesForStores < ActiveRecord::Migration
  def change
  	create_join_table :dealers, :stores do |t|
    	t.index :dealer_id
    	t.index :store_id
    end

    create_join_table :stores, :zones do |t|
    	t.index :store_id
    	t.index :zone_id
    end

  end
end
