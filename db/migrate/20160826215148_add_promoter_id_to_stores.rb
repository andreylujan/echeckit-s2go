# -*- encoding : utf-8 -*-
class AddPromoterIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :promoter_id, :integer
    add_index :stores, :promoter_id
  end
end
