class Api::V1::PromoterActivityResource < JSONAPI::Resource
	attributes :reports_by_day, :accumulated_reports,
		:num_reports_yesterday, :num_reports_today,
		:checkins_by_day, :accumulated_checkins,
		:num_checkins_yesterday, :num_checkins_today,
		:hours_by_day, :accumulated_hours,
		:num_hours_yesterday, :num_hours_today,
		:head_counts, :head_counts_by_store,
		:year, :month
end
