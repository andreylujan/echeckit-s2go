class Api::V1::ReportsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  
  def context
    super.merge({ all: params[:all] })
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


  def create_params
  	params.permit(:report_type_id, :finished, :assigned_user_id).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end
end
