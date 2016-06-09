# -*- encoding : utf-8 -*-
class AddLimitDateToReports < ActiveRecord::Migration
  def change
    add_column :reports, :limit_date, :datetime
  end
end
