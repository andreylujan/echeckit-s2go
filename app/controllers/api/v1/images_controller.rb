# -*- encoding : utf-8 -*-
class Api::V1::ImagesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

  def index

    images = Image.joins(report: :store)

    if params[:start_date].present?
      images = images.where("images.created_at >= ?", params[:start_date])
    end

    if params[:end_date].present?
      images = images.where("images.created_at <= ?", params[:end_date])
    end

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

    images = images
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

    best_practices = images.page(page_number).per(page_size)
    .map { |p| Api::V1::ImageResource.new(p, nil) }

    serializer = JSONAPI::ResourceSerializer.new(Api::V1::ImageResource,
                                                 include: params[:include].split).serialize_to_hash(best_practices)

    meta = {
      meta: {
        record_count: images.count,
        page_count: (images.count.to_f/page_size.to_f).ceil
      }
    }
    render json: serializer.merge(meta)



  end

  def create
    begin
      image = Image.new(create_params)
    rescue => exception
      if params[:report_id].present? and params[:last_image]
        report = Report.find(params[:report_id])
        report.generate_pdf
        image = Image.new
        render json: image
        return
      end
    end
    image.user = current_user
    image.save!
    if report = image.report
      if params[:last_image] or (report.dynamic_attributes["num_images"].present? and report.dynamic_attributes["num_images"] <= report.images.count)
        report.generate_pdf
      end
    end
    
    render json: image
  end

  def create_params
    params.permit(:image, :remote_image_url, :data_part_id, :category_id, :report_id, :detail_id)
  end
end
