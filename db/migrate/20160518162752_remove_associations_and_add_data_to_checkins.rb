class RemoveAssociationsAndAddDataToCheckins < ActiveRecord::Migration
  def change
  	remove_column :checkins, :zone_id
  	remove_column :checkins, :dealer_id
  	remove_column :checkins, :store_id
  	remove_column :checkins, :subsection_id
  	add_column :checkins, :data, :json, null: false, default: {}
  end
end
