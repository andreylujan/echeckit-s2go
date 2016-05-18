class RenameLonlatInCheckins < ActiveRecord::Migration
  def change
  	rename_column :checkins, :lonlat, :arrival_lonlat
  end
end
