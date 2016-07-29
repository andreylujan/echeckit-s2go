# -*- encoding : utf-8 -*-
class CreateSaleGoals < ActiveRecord::Migration
  def change
    create_table :sale_goals do |t|
      t.references :store, index: true, foreign_key: true, null: false
      t.integer :monthly_goal, null: false

      t.timestamps null: false
    end
  end
end
