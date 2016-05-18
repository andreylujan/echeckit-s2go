class AddLonlatToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :lonlat, :st_point
    add_index :checkins, :lonlat, using: :gist
  end
end
