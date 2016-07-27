class Api::V1::PromoterActivityResource < JSONAPI::Resource
	attributes :reports_by_day, :accumulated_reports,
		:checkins_by_day, :accumulated_checkins,
		:hours_by_day, :accumulated_hours,
		:head_counts, :head_counts_by_store,
		:best_practices,
		:year, :month
end
