# -*- encoding : utf-8 -*-
class Api::V1::SectionsController < ApplicationController

  before_action :doorkeeper_authorize!

  def index
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
  end
end
