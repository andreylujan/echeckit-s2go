# -*- encoding : utf-8 -*-
class RemoveStoreReferenceFromDailyHeadCounts < ActiveRecord::Migration
  def change
    remove_reference :daily_head_counts, :store, index: true, foreign_key: true
  end
end
