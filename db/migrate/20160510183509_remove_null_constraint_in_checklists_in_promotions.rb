# -*- encoding : utf-8 -*-
class RemoveNullConstraintInChecklistsInPromotions < ActiveRecord::Migration
  def change
  	change_column :promotions, :checklist_id, :integer, null: true
  end
end
