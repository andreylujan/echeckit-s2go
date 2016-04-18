class AddFinishedAndAssignedUserIdToReports < ActiveRecord::Migration
  def change
    add_column :reports, :finished, :boolean
    add_column :reports, :assigned_user_id, :integer
  end
end
