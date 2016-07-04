class Api::V1::SaleGoalUploadsController < Api::V1::JsonApiController

	before_action :doorkeeper_authorize!


	def context
		{
			year: params.require(:year),
			month: params.require(:month)
		}
	end
end
