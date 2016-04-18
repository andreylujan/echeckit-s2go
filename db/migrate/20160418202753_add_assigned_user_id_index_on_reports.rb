class AddAssignedUserIdIndexOnReports < ActiveRecord::Migration
  def change
  	add_index :reports, :assigned_user_id
  end
end
