class RenamePictureInUsers < ActiveRecord::Migration
  def change
  	rename_column :users, :picture, :image
  end
end