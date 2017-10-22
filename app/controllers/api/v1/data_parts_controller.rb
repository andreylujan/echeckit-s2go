# -*- encoding : utf-8 -*-
class Api::V1::DataPartsController < Api::V1::JsonApiController
  before_action :doorkeeper_authorize!


  def index
    type = params.require(:type)
    if type == "Checklist"
    	render 'checklist'
    elsif type == "ChecklistOption"
    	render 'checklist_option'
    else
      render json: {
        "errors": [
          {
            "status": "422",
            "title": "Tipo inválido",
            "detail": "El solicitado deber ser Checklist o ChecklistOption"
          }
        ]
      }, status: :unprocessable_entity
      return
    end
  end

  def show
  	id = params.require(:id).to_i
  	if id == 1
  		render '1'
  	elsif id == 3
  		render '3'
  	else
  		ender json: {
        "errors": [
          {
            "status": "422",
            "title": "Id inválido",
            "detail": "El id deber ser 1 o 3"
          }
        ]
      }, status: :unprocessable_entity
  	end
  end

end
