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

  def create
    if params[:unique_id].present?
      report = Report.find_by_unique_id(params[:unique_id])
      if report.nil?
        super
      else
        render json: report, status: :created
      end
    else
      super
    end
  end

  def update
    @report = Report.find(params.require(:id))
    if @report.finished?
      render json: {
        errors: [
          {
            status: "409",
            title: "Tarea ya ha sido completada",
            detail: "La tarea ya ha sido completada por otro promotor, supervisor o instructor de la misma tienda"
          }
        ]
      }, status: :conflict
    else
      @report.finished = true
      @report.executor = current_user
      if @report.update_attributes! update_params
        render json: @report
      else
        render json: @report, status: :unprocessable_entity
      end
    end
  end

  def destroy
    if params[:id].present?
      @report = Report.find(params.require(:id))
      if @report.nil?
        super
      else
        @report.destroy()
        render json: {
        success: [
          {
            status: "200",
            title: "Eliminado con exito",
            detail: "La tarea fue eliminada con exito"
          }
        ]
      }, status: 200
      end
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
    params.permit(:report_type_id, :finished, :limit_date, :unique_id).tap do |whitelisted|
      whitelisted[:dynamic_attributes] = params[:dynamic_attributes]
    end
  end
end
