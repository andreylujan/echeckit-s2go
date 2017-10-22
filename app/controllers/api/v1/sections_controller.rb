# -*- encoding : utf-8 -*-
class Api::V1::SectionsController < ApplicationController

  before_action :doorkeeper_authorize!

  def index
    if params["filter"] and params["filter"]["section_type"] and
      params["filter"]["section_type"]["name"]

      sections = Section.joins(:section_type)
      .where(organization_id: current_user.role.organization_id)
      .where(section_types: { name: params["filter"]["section_type"]["name"] })
      render json: sections, include: 'subsections.data_parts'
      return
    end

    report_type_id = params.require(:report_type_id)
    if report_type_id == "1"
      render '1'
    elsif report_type_id == "2"
      render '2'
    else
      render json: {
        "errors": [
          {
            "status": "404",
            "title": "No encontrado",
            "detail": "El objeto solicitado no ha sido encontrado"
          }
        ]
      }, status: :not_found
    end
    # @sections = ReportType.includes(sections: [ :section_type, subsections: [:data_parts]])
    # .find(report_type_id).sections.order(:position)

    # render json: @sections, include: 'subsections.data_parts'
  end
end
