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
#  deleted_at          :datetime
#  unit_monthly_goal   :integer          not null
#  goal_category       :string           not null
#

class StockChart < ActiveRecord::Base
	belongs_to :store
	belongs_to :stock_chart_upload
	validates_presence_of :store, :stock_date
	# validates :monthly_goal, :numericality => { :greater_than_or_equal_to => 0 }

	acts_as_paranoid

	acts_as_xlsx columns: [
	                      :id, 
	                      :dealer,
	                      :stock_category,
	                      :store_code,
	                      :store_name,                      	                      
	                      :week,
	                      :year,
	                      :month,	                     
	                      :unit_stock
	                    ]

	# def store_code
	# store.code
	# end

	# def stock_month
	# stock_date.month.to_i
	# end

	# def stock_year
	# stock_date.year.to_i
	# end

	# def dealer_criteria
	# store.dealer
	# end

	# def zone_name
	# store.zone.name
	# end

	# def dealer_name
	# store.dealer.name
	# end

	# def store_name
	# store.name
	# end
end
