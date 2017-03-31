# -*- encoding : utf-8 -*-
class Api::V1::PromotionStatesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!


  def destroy
    if params[:id].present?
      @promotion = PromotionState.find(params.require(:id))
      if @promotion.nil?
        super
      else
        @promotion.destroy()
        render json: {
        success: [
          {
            status: "200",
            title: "Eliminado con exito",
            detail: "La promocion fue eliminada con exito"
          }
        ]
      }, status: 200
      end
    end
  end
  
end
