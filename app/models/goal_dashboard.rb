# -*- encoding : utf-8 -*-
class GoalDashboard
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :monthly_sales_vs_goals
	attr_accessor :weekly_sales_vs_goals
	attr_accessor :monthly_sales_comparison
	attr_accessor :weekly_sales_comparison
end
