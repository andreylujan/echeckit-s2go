class AddTitleAndDescriptionToReportsAndTaskStartAndTaskEndToReports < ActiveRecord::Migration
  def change
    add_column :reports, :title, :text
    add_column :reports, :description, :text
    add_column :reports, :task_start, :datetime
    add_column :reports, :task_end, :datetime
  end
end
