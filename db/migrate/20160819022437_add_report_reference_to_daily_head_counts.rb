class AddReportReferenceToDailyHeadCounts < ActiveRecord::Migration
  def change
    add_reference :daily_head_counts, :report, index: true, foreign_key: true
  end
end
