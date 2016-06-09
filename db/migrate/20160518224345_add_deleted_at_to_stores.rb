# -*- encoding : utf-8 -*-
class AddDeletedAtToStores < ActiveRecord::Migration
  def change
    add_column :stores, :deleted_at, :datetime
    add_index :stores, :deleted_at
  end
end
