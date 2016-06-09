# -*- encoding : utf-8 -*-
class ChangeDefaultInPositionInDataParts < ActiveRecord::Migration
  def change
  	change_column :data_parts, :position, :integer, default: 0, null: false
  end
end
