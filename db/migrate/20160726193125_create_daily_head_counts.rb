# -*- encoding : utf-8 -*-
class CreateDailyHeadCounts < ActiveRecord::Migration
  def change
    create_table :daily_head_counts do |t|
      t.references :store, index: true, foreign_key: true
      t.datetime :count_date
      t.integer :num_full_time
      t.integer :num_part_time
      t.references :brand, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
