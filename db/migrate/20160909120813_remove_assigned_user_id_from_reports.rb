class RemoveAssignedUserIdFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :assigned_user_id, :integer
  end
end
