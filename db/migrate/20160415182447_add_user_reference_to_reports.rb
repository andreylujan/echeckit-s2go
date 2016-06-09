# -*- encoding : utf-8 -*-
class AddUserReferenceToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :creator_id, :integer, null: false
  	add_index :reports, :creator_id
    rename_column :reports, :data, :dynamic_attributes
  end
end
