class AddSaleGoalUploadReferenceToSaleGoals < ActiveRecord::Migration
  def change
    add_reference :sale_goals, :sale_goal_upload, index: true, foreign_key: true
  end
end
