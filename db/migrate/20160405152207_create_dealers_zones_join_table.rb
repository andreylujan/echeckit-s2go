class CreateDealersZonesJoinTable < ActiveRecord::Migration
  def change
    create_table :dealers_zones, id: false do |t|
        t.integer :dealer_id
        t.integer :zone_id
    end

    add_index :dealers_zones, [ :dealer_id, :zone_id ], unique: true
  end
end
