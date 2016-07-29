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
	attributes :last_year, :current_year,
		:last_week_of_year, :current_week_of_year,
		:monthly_sales_vs_goals, :last_week_comparison,
		:weekly_sales_comparison, :monthly_sales_comparison
		
end
