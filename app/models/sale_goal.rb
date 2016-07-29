# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: sale_goals
#
#  id                  :integer          not null, primary key
#  store_id            :integer          not null
#  monthly_goal        :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  goal_date           :datetime         not null
#  sale_goal_upload_id :integer
#

class SaleGoal < ActiveRecord::Base
  belongs_to :store
  belongs_to :sale_goal_upload
  validates_presence_of :store, :goal_date
  validates :monthly_goal, :numericality => { :greater_than_or_equal_to => 0 }

  def dealer_criteria
  	store.dealer
  end
end
