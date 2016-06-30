class RenameDateToGoalDateInSaleGoals < ActiveRecord::Migration
  def change
  	rename_column :sale_goals, :date, :goal_date
  end
end
