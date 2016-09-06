# -*- encoding : utf-8 -*-
class Api::V1::WeeklyBusinessSalesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  def csv
  	csv_file = params.require(:csv)
    json = WeeklyBusinessSale.from_csv(csv_file)
    if json[:errors]
    	render json: json, status: :unprocessable_entity
    else
    	render json: json, status: :ok
    end
  end
end
