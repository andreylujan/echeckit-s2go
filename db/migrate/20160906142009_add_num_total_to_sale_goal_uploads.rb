class AddNumTotalToSaleGoalUploads < ActiveRecord::Migration
  def change
    add_column :sale_goal_uploads, :num_total, :integer
  end
end
