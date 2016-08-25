# -*- encoding : utf-8 -*-
class RemoveStoreReferenceFromDailySales < ActiveRecord::Migration
  def change
    remove_reference :daily_sales, :store, index: true, foreign_key: true
  end
end
