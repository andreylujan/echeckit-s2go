# -*- encoding : utf-8 -*-
class Api::V1::ImagesController < ApplicationController

  before_action :doorkeeper_authorize!

  def index

    month = params.require(:month)
    year = params.require(:year)
    start_date = DateTime.new(year.to_i, month.to_i)
    end_date = start_date + 1.month
    sales = MonthlySale.joins(:store).where(start_date: start_date)

    images = Image.joins(report: :store).
      where("reports.created_at >= ? AND reports.created_at < ?", start_date, end_date)

    if params[:category_id].present?
      images = images.where(category_id: params[:category_id].to_i)
    end

    if params[:store_id].present?
      images = images.where(reports: { store_id: params[:store_id].to_i })
    end

    if params[:dealer_id].present?
      images = images.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      images = images.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      images = images.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      images = images.where(stores: { zone_id: params[:zone_id].to_i })
    end

    best_practices = images
    .order("created_at DESC")
    page_size = 15
    page_number = 1

    if params[:page].present?
      
      if params[:page][:size].present?
        page_size = params[:page][:size]
      end

      if params[:page][:number].present?
        page_number = params[:page][:number]
      end
      
    end

    best_practices = best_practices.page(page_number).per(page_size)
    .map { |p| Api::V1::ImageResource.new(p, nil) }

    render json: JSONAPI::ResourceSerializer.new(Api::V1::ImageResource,
                                                 include: params[:include].split,
                                                 fields: {
                                                   images: [ :url, :category ]
    }).serialize_to_hash(best_practices)


  end

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
