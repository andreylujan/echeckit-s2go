class AddImageListToChecklistItemValues < ActiveRecord::Migration
  def change
    add_column :checklist_item_values, :image_list, :json, default: []
  end
end
