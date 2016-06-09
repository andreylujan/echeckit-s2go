# -*- encoding : utf-8 -*-
class RenameDataPartIdInPromotionsToChecklistId < ActiveRecord::Migration
  def change
  	rename_column :promotions, :data_part_id, :checklist_id
  end
end
