# -*- encoding : utf-8 -*-
class Api::V1::ReportsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

  def context
    super.merge({ 
      all: params[:all],
      only_assigned: @only_assigned,
      only_daily: @only_daily
      })
  end

  def update
    @report = Report.find(params.require(:id))
    @report.finished = true

    if @report.update_attributes! update_params
      render json: @report
    else
      render json: @report, status: :unprocessable_entity
    end
  end

  def index
    if request.url.include? 'daily_reports'
      @only_daily = true
      super
      return
    end

    if request.url.include? 'assigned_reports'
      @only_assigned = true
      super
      return
    end

    super
  end

  

  def update_params
    params.permit(:finished).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end

  def create_params
    params.permit(:report_type_id, :finished, :limit_date).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end
end
