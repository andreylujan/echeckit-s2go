# -*- encoding : utf-8 -*-
class Api::V1::DataPartsController < Api::V1::JsonApiController
  before_action :doorkeeper_authorize!


  def index
    if params["filter"].present?
      type = params["filter"]["type"]
    else
      type = params["type"]
    end
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
            "detail": "El type deber ser Checklist o ChecklistOption"
          }
        ]
      }, status: :unprocessable_entity
      return
    end
  end

  def show
  	id = params.require(:id).to_i
    render json: JSONAPI::ResourceSerializer.new(Api::V1::ChecklistResource)
        .serialize_to_hash(Api::V1::ChecklistResource.new(Checklist.find(id), nil))
  end

end
