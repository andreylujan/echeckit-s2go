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

			if params[:stock_category].present?
				stock = stock.where(stock_category: params[:stock_category])
			end

			new_stock = []
			categories = []
			total_stock = 0

			stock_by_categories = stock.group_by(&:stock_category)	
			stock_by_categories.each do |item|
				categories.push(item[0])
			end

			categories.each do |cat|
				stock.each do |item|
					if cat == item[:stock_category]
						total_stock = total_stock + item[:unit_stock].to_i
					end
				end
				new_stock.push({
					category: cat,
					total_stock: total_stock
				})
				total_stock = 0
			end

			render json: {
		    data: new_stock
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
