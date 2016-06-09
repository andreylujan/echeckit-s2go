# -*- encoding : utf-8 -*-
class AddPositionToDataParts < ActiveRecord::Migration
  def change
    add_column :data_parts, :position, :integer
  end
end
