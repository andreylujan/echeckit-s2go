class RenameNumErrorInSaleGoalUploads < ActiveRecord::Migration
  def change
  	rename_column :sale_goal_uploads, :num_error, :num_errors
  end
end
