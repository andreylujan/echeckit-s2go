# -*- encoding : utf-8 -*-
class AddStockBreakQuantityToStockBreakEvents < ActiveRecord::Migration
  def change
    add_column :stock_break_events, :stock_break_quantity, :integer
  end
end
