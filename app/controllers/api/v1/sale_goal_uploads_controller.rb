# -*- encoding : utf-8 -*-
class Api::V1::SaleGoalUploadsController < Api::V1::JsonApiController

	before_action :doorkeeper_authorize!


	def context
		{
			year: params[:year],
			month: params[:month]
		}
	end
end
