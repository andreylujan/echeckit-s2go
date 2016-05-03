class Api::V1::ImagesController < ApplicationController

  before_action :doorkeeper_authorize!

  def create
  	image = Image.new(create_params)
  	image.user = current_user
  	image.save!
    if params[:last_image]
      image.report.generate_pdf
    end
  	render json: image
  end
  
  def create_params
  	params.permit(:image, :data_part_id, :category_id, :report_id, :detail_id)
  end
end
