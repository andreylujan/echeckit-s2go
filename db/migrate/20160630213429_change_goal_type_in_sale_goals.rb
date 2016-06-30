class ChangeGoalTypeInSaleGoals < ActiveRecord::Migration
  def change
  	change_column :sale_goals, :goal_date, :datetime, null: false
  end
end
