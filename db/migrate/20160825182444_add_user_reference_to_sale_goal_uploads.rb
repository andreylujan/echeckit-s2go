# -*- encoding : utf-8 -*-
class AddUserReferenceToSaleGoalUploads < ActiveRecord::Migration
  def change
    add_reference :sale_goal_uploads, :user, index: true, foreign_key: true
  end
end
