# -*- encoding : utf-8 -*-
class Api::V1::ImagesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

  def create
  	image = Image.new(create_params)
  	image.user = current_user
  	image.save!
    if params[:last_image] and image.report.present?
      image.report.generate_pdf
    end
  	render json: image
  end
  
  def create_params
  	params.permit(:image, :remote_image_url, :data_part_id, :category_id, :report_id, :detail_id)
  end
end
