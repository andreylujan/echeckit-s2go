class PromoterActivity
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :reports_by_day
	attr_accessor :accumulated_reports
	attr_accessor :checkins_by_day
	attr_accessor :accumulated_checkins
	attr_accessor :hours_by_day
	attr_accessor :accumulated_hours
	attr_accessor :head_counts
	attr_accessor :head_counts_by_store
	attr_accessor :year
	attr_accessor :month
	attr_accessor :num_reports_yesterday
	attr_accessor :num_reports_today
	attr_accessor :num_checkins_yesterday
	attr_accessor :num_checkins_today
	attr_accessor :num_hours_yesterday
	attr_accessor :num_hours_today
end