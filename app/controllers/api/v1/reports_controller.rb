# -*- encoding : utf-8 -*-
class Api::V1::ReportsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  
  def context
    super.merge({ all: params[:all] })
  end
  
  def update    
    @report = Report.find(params.require(:id))
    @report.finished = true

    if @report.update_attributes update_params
      render json: @report
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  def update_params
    params.permit(:finished).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end

  def create_params
  	params.permit(:report_type_id, :finished, :assigned_user_id, :limit_date).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end
end
