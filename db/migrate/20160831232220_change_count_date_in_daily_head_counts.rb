class ChangeCountDateInDailyHeadCounts < ActiveRecord::Migration
  def change
  	change_column :daily_head_counts, :count_date, :date
  end
end
