# -*- encoding : utf-8 -*-
class GoalDashboard
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :last_year
	attr_accessor :current_year
	attr_accessor :last_week_of_year
	attr_accessor :current_week_of_year
	attr_accessor :monthly_sales_vs_goals
	attr_accessor :last_week_comparison
	attr_accessor :monthly_sales_comparison
	attr_accessor :weekly_sales_comparison
end
