class CreateJoinTableReportsUsers < ActiveRecord::Migration
  def change
  	create_join_table :reports, :users do |t|
    	t.index :report_id
    	t.index :user_id
    end
    add_column :reports, :is_task, :boolean, null: false, default: false
    Report.where.not(assigned_user_id: nil).each do |report|
    	report.assigned_user_ids = [ report.assigned_user_id ]
      report.is_task = true
    	report.save!
    end
  end
end
