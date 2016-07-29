# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_breaks
#
#  id                        :integer          not null, primary key
#  dealer_id                 :integer
#  store_type_id             :integer
#  product_classification_id :integer
#  stock_break               :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Api::V1::GoalDashboardResource < BaseResource
	attributes :monthly_sales_vs_goals, :weekly_sales_vs_goals,
		:monthly_sales_comparison, :weekly_sales_comparison
end
