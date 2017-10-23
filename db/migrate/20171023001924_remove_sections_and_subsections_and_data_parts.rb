class RemoveSectionsAndSubsectionsAndDataParts < ActiveRecord::Migration
  def change
  	remove_foreign_key :images, :data_parts
  	remove_foreign_key :promotions, :checklists
  	add_foreign_key :promotions, :checklists
  	remove_foreign_key :checklist_item_values, :data_parts
  	rename_column :checklist_item_values, :data_part_id, :checklist_item_id
  	add_foreign_key :checklist_item_values, :checklist_items
  	drop_table :data_parts
  	drop_table :subsections
  	drop_table :sections
  	drop_table :section_types
  end
end
