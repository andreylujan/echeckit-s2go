class Api::V1::DataPartsController < ApplicationController

  before_action :doorkeeper_authorize!

  def index
  	parts = 
  		current_user.organization.data_parts.where(type: params.require(:type))
  	render json: parts
  end
  
end
