# -*- encoding : utf-8 -*-
class AddReportReferenceToDailyProductSales < ActiveRecord::Migration
  def change
    add_reference :daily_product_sales, :report, index: true, foreign_key: true
  end
end
