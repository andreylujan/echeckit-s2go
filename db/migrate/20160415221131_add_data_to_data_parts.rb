class AddDataToDataParts < ActiveRecord::Migration
  def change
    add_column :data_parts, :data, :json
  end
end
