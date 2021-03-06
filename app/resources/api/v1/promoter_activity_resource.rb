# -*- encoding : utf-8 -*-
class Api::V1::PromoterActivityResource < BaseResource
	attributes :reports_by_day, :accumulated_reports,
		:num_reports_yesterday, :num_reports_today,
		:checkins_by_day, :accumulated_checkins,
		:num_checkins_yesterday, :num_checkins_today,
		:hours_by_day, :accumulated_hours,
		:num_hours_yesterday, :num_hours_today,
		:head_counts, :head_counts_by_store,
		:percent_prices_communicated_yesterday,
		:percent_prices_communicated_today,
		:communicated_prices_by_store,
		:prices_by_day,
		:accumulated_prices,
		:percent_promotions_communicated_yesterday,
		:percent_promotions_communicated_today,
		:communicated_promotions_by_store,
		:promotions_by_day,
		:accumulated_promotions,
		:year, :month,
		:best_practices
end
