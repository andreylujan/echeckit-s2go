class Api::V1::PromoterActivityResource < JSONAPI::Resource
	attributes :reports_by_day, :accumulated_reports,
		:checkins_by_day, :accumulated_checkins,
		:year, :month
end
