# -*- encoding : utf-8 -*-
class AddDeletedAtToStockBreaks < ActiveRecord::Migration
  def change
    add_column :stock_breaks, :deleted_at, :datetime
  end
end
