class AddIndexOnStoreName < ActiveRecord::Migration
  def change
  	add_index :stores, [ :name, :dealer_id, :zone_id ], unique: true
  end
end
