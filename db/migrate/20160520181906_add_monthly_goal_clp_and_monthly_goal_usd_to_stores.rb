# -*- encoding : utf-8 -*-
class AddMonthlyGoalClpAndMonthlyGoalUsdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :monthly_goal_clp, :integer
    add_column :stores, :monthly_goal_usd, :decimal, precision: 8, scale: 2
  end
end
