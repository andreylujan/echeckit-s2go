class Api::V1::DataPartsController < ApplicationController

  before_action :doorkeeper_authorize!

  def index
  	parts = 
  		current_user.organization.data_parts.where(type: params.require(:type))

  	each_serializer = Object.const_get("#{params[:type]}Serializer")
  		render json: parts, each_serializer: each_serializer
  	
  end
  
end
