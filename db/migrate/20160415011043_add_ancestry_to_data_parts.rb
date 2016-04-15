class AddAncestryToDataParts < ActiveRecord::Migration
  def change
    add_column :data_parts, :ancestry, :string
    add_index :data_parts, :ancestry
  end
end
