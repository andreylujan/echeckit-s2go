class Api::V1::StockchartlistController < ApplicationController
	
	before_action :doorkeeper_authorize!

	def index		
		begin
			params = request.query_parameters

			stock = StockChart.all

			if params[:store_id].present?
				stock = stock.where(store_id: params[:store_id])
			end

			if params[:store_code].present?
				stock = stock.where(store_code: params[:store_code])
			end

			if params[:dealer].present?
				stock = stock.where(dealer: params[:dealer])
			end

			if params[:week].present?
				stock = stock.where(week: params[:week])
			end

			render json: {
		    data: stock
		  }, status: :ok
		  return

    rescue => exception
      render json: {
        errors: [{
                   title: exception.message,
                   detail: exception.message
                 }
                 ]
      }, status: :unprocessable_entity
    end
	end

end
