class AddNumApoyoTimeToDailyHeadCounts < ActiveRecord::Migration
  def change
    add_column :daily_head_counts, :num_apoyo_time, :integer, null: false, default: 0
  end
end
