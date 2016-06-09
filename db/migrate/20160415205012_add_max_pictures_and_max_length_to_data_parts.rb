# -*- encoding : utf-8 -*-
class AddMaxPicturesAndMaxLengthToDataParts < ActiveRecord::Migration
  def change
    add_column :data_parts, :max_pictures, :integer
    add_column :data_parts, :max_length, :integer
  end
end
