# -*- encoding : utf-8 -*-
class RemoveStockBreakDateFromStockBreakEvents < ActiveRecord::Migration
  def change
    remove_column :stock_break_events, :stock_break_date, :datetime
  end
end
