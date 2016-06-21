# -*- encoding : utf-8 -*-
class Api::V1::DataPartsController < Api::V1::JsonApiController

	before_action :doorkeeper_authorize!


	def index
		if params[:type]
			parts = 
			current_user.organization.data_parts.where(type: params.require(:type))

			each_serializer = Object.const_get("#{params[:type]}Serializer")
			render json: parts, each_serializer: each_serializer
		else
			super
		end  	
	end

end
