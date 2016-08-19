class AddReportReferenceToStockBreakEvents < ActiveRecord::Migration
  def change
    add_reference :stock_break_events, :report, index: true, foreign_key: true
  end
end
