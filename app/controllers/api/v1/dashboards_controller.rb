class Api::V1::DashboardsController < Api::V1::JsonApiController
  def sales
    month = params.require(:month)
    year = params.require(:year)
    sales_date = DateTime.new(year.to_i, month.to_i)
    sales = MonthlySale.joins(:store).where(sales_date: sales_date)
    
    if params[:store_id].present?
    	sales = sales.where(store_id: params[:store_id].to_i)
    end

    if params[:zone_id].present?
    	sales = sales.where(stores: { zone_id: params[:zone_id].to_i })
    end

    if params[:dealer_id].present?
    	sales = sales.where(stores: { dealer_id: params[:dealer_id].to_i })
    end

    if params[:instructor_id].present?
    	sales = sales.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
    	sales = sales.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    sales_by_company = [

    ]

    Brand.all.each do |brand|
      brand_sales = sales.where(brand: brand).first
      hardware = 0
      accessories = 0
      games = 0
      if brand_sales.present?
        hardware = brand_sales.hardware_sales
        accessories = brand_sales.accessory_sales
        games = brand_sales.game_sales
      end
      company_sales = {
        name: brand.name,
        sales_by_type: {
          hardware: hardware,
          accessories: accessories,
          games: games
        }
      }
      sales_by_company << company_sales

    end
    data = {
      sales_by_company: sales_by_company,
      year: year,
      month: month,
      id: sales_date
    }
    report = SalesReport.new data


    render json: JSONAPI::ResourceSerializer.new(Api::V1::SalesReportResource)
    .serialize_to_hash(Api::V1::SalesReportResource.new(report, nil))
  end
end
