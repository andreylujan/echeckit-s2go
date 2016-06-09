# -*- encoding : utf-8 -*-
class ChangeFinishedDefaultValueInReports < ActiveRecord::Migration
  def change
  	change_column :reports, :finished, :boolean, null: false, default: false
  end
end
