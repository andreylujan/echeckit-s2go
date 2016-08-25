# -*- encoding : utf-8 -*-
class AddReportReferenceToDailySales < ActiveRecord::Migration
  def change
    add_reference :daily_sales, :report, index: true, foreign_key: true
  end
end
