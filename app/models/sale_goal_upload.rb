# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: sale_goal_uploads
#
#  id           :integer          not null, primary key
#  result_csv   :text
#  uploaded_csv :text
#  goal_date    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  num_uploaded :integer          default(0), not null
#  num_error    :integer          default(0), not null
#

class SaleGoalUpload < ActiveRecord::Base
  has_many :sale_goals
  mount_uploader :result_csv, GoalCsvUploader
  mount_uploader :uploaded_csv, GoalCsvResultUploader
  belongs_to :user
  def user_email
    user.email if user.present?
  end
end
