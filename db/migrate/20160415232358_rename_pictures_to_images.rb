# -*- encoding : utf-8 -*-
class RenamePicturesToImages < ActiveRecord::Migration
  def change
  	rename_table :pictures, :images
  	rename_table :categories_pictures, :categories_images
  	rename_column :categories_images, :picture_id, :image_id
  	rename_column :data_parts, :max_pictures, :max_images
  end
end
