# -*- encoding : utf-8 -*-
class AddDefaultValueToHeadCounts < ActiveRecord::Migration
  def change
  	change_column :daily_head_counts, :num_full_time, :integer, null: false, default: 0
  	change_column :daily_head_counts, :num_part_time, :integer, null: false, default: 0
  end
end
