class RemovePromoterIdFromStores < ActiveRecord::Migration
  def change
    remove_column :stores, :promoter_id, :integer
  end
end
