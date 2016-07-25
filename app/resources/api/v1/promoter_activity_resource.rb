class Api::V1::PromoterActivityResource < JSONAPI::Resource
	attributes :reports_by_day, :accumulated, :year, :month
end
