class RemoveNumUploadedFromSaleGoalUploads < ActiveRecord::Migration
  def change
    remove_column :sale_goal_uploads, :num_uploaded, :integer
  end
end
