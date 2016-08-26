# -*- encoding : utf-8 -*-
class AddFinishedAtAndTaskStartAndTitleAndDescriptionToReports < ActiveRecord::Migration
  def change
    add_column :reports, :finished_at, :datetime
    add_index :reports, :finished
    add_column :reports, :task_start, :datetime
    add_column :reports, :title, :text
    add_column :reports, :description, :text
  end
end
