class ChangeItemValueInChecklistItemValues < ActiveRecord::Migration
  def change
  	change_column :checklist_item_values, :item_value, :boolean, null: true
  end
end
