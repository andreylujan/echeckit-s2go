# -*- encoding : utf-8 -*-
class AddChecklistItemReferenceToChecklistItemValues < ActiveRecord::Migration
  def change
    add_reference :checklist_item_values, :data_part, index: true, foreign_key: true, null: false
  end
end
