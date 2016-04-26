class AddDefaultValueToDataInDataParts < ActiveRecord::Migration
  def change
  	change_column :data_parts, :data, :json, null: false, default: {}
  end
end
