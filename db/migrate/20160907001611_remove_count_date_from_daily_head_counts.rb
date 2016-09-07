class RemoveCountDateFromDailyHeadCounts < ActiveRecord::Migration
  def change
    remove_column :daily_head_counts, :count_date, :date
  end
end
