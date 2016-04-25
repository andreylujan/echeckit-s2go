class AddDetailIdToDataParts < ActiveRecord::Migration
  def change
    add_column :data_parts, :detail_id, :integer
    add_index :data_parts, :detail_id
  end
end
