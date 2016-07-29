# -*- encoding : utf-8 -*-
class CreateSaleGoalUploads < ActiveRecord::Migration
  def change
    create_table :sale_goal_uploads do |t|
      t.text :result_csv
      t.text :uploaded_csv
      t.datetime :goal_date

      t.timestamps null: false
    end
  end
end
