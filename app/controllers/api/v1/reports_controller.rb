class Api::V1::ReportsController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
  
  def context
    {
      current_user: current_user,
      all: params[:all]
    }
  end
  
  def create
  	@report = Report.new(create_params)
    @report.set_uuid
  	user = current_user
  	@report.creator = user
  	@report.organization_id = user.role.organization_id
  	if @report.save!
  		render json: @report
  	else
  	end
  end

  def index
    super
  end

  def create_params
  	params.permit(:report_type_id, :finished, :assigned_user_id).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end
end
