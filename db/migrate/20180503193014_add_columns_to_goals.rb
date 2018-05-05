class AddColumnsToGoals < ActiveRecord::Migration
  def change
    add_column :sale_goals, :unit_monthly_goal, :integer, default: 0 , null: false
    add_column :sale_goals, :goal_category, :string , default: '', null:false
    SaleGoal.reset_column_information
    goals = SaleGoal.all
    goals.each do |goal|
      goal.update_column :unit_monthly_goal, 0
      goal.update_column :goal_category, ''
    end
  end
end
