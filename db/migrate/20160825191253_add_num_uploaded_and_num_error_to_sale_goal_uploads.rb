# -*- encoding : utf-8 -*-
class AddNumUploadedAndNumErrorToSaleGoalUploads < ActiveRecord::Migration
  def change
    add_column :sale_goal_uploads, :num_uploaded, :integer, null: false, default: 0
    add_column :sale_goal_uploads, :num_error, :integer, null: false, default: 0
  end
end
