class RemoveStoreReferenceFromStockBreakEvents < ActiveRecord::Migration
  def change
    remove_reference :stock_break_events, :store, index: true, foreign_key: true
  end
end
