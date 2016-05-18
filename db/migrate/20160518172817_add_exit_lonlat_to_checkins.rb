class AddExitLonlatToCheckins < ActiveRecord::Migration
  def change
  	add_column :checkins, :exit_lonlat, :st_point
  	add_index :checkins, :exit_lonlat, using: :gist
  	add_column :checkins, :address, :text
  end
end
