class Api::V1::DashboardsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

  def promoter_activity
    month = params.require(:month)
    year = params.require(:year)
    start_date = DateTime.new(year.to_i, month.to_i)
    end_date = start_date + 1.month
    days_in_month = start_date.end_of_month.day
    current_date = DateTime.now
    reports = Report.where("created_at > ? AND created_at < ?", start_date, end_date)
    groups = reports.group_by(&:group_by_criteria).map {|k,v| [k, v.length]}.sort
    current_index = 0
    filled_in_groups = []

    days_in_month.times do |i|
      if groups[current_index] && groups[current_index][0].day == (i + 1)
        filled_in_groups << groups[current_index]
        current_index += 1
      else
        date = DateTime.new(year.to_i, month.to_i, (i + 1)).to_date
        if current_date > date
          new_day = [ date, 0 ]
        else
          new_day = [ date, -1 ]
        end
        filled_in_groups << new_day
      end
    end

    groups = filled_in_groups

    reports_by_day = groups.map do |group|
      {
        week_day: I18n.l(group[0], format: '%A').capitalize,
        month_day: group[0].day,
        amount: group[1]
      }
    end
    shortened_groups = groups
    if DateTime.now < end_date
      shortened_groups = groups[0..(DateTime.now.day - 1)]
    end

    accumulated = shortened_groups.each_with_index.map do |e, i|
      sum = shortened_groups[0..i].inject(0) do |memo, obj|
        if obj[1] >= 0
          obj[1] + memo
        else
          memo
        end
      end
      [ e[0].day, sum ]
    end

    data = {
      id: start_date,
      year: year,
      month: month,
      reports_by_day: reports_by_day,
      accumulated: accumulated
    }

    promoter_activity = PromoterActivity.new data

    render json: JSONAPI::ResourceSerializer.new(Api::V1::PromoterActivityResource)
    .serialize_to_hash(Api::V1::PromoterActivityResource.new(promoter_activity, nil))

  end

  def sales
    month = params.require(:month)
    year = params.require(:year)
    sales_date = DateTime.new(year.to_i, month.to_i)
    end_date = sales_date + 1.month
    sales = MonthlySale.joins(:store).where(sales_date: sales_date)

    if params[:store_id].present?
      sales = sales.where(store_id: params[:store_id].to_i)
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

    sales_by_zone = [
    ]

    total_sales = sales.sum(:hardware_sales) + sales.sum(:accessory_sales) + sales.sum(:game_sales)

    Zone.all.each do |zone|

      zone_sales = sales.where(stores: { zone_id: zone.id })
      num_zone_sales = zone_sales.sum(:hardware_sales) + zone_sales.sum(:accessory_sales) +
        zone_sales.sum(:game_sales)


      brands_array = [
      ]
      Brand.all.each do |brand|
        brand_sales = zone_sales.where(brand: brand)
        sales_amount = brand_sales.sum(:hardware_sales) + brand_sales.sum(:accessory_sales) +
          brand_sales.sum(:game_sales)
        share_percentage = num_zone_sales > 0 ? sales_amount.to_f/num_zone_sales.to_f : 0
        brand_obj = {
          name: brand.name,
          sales_amount: sales_amount,
          share_percentage: share_percentage
        }
        brands_array << brand_obj
      end

      zones_obj = {
        name: zone.name,
        sales_amount: num_zone_sales,
        sales_by_company: brands_array
      }
      sales_by_zone << zones_obj
    end


    if params[:zone_id].present?
      sales = sales.where(stores: { zone_id: params[:zone_id].to_i })
    end

    share_percentages = [

    ]

    sales_by_company = [

    ]

    total_sales = sales.sum(:hardware_sales) + sales.sum(:accessory_sales) + sales.sum(:game_sales)

    Brand.all.each do |brand|
      brand_sales = sales.where(brand: brand)
      sales_amount = brand_sales.sum(:hardware_sales) + brand_sales.sum(:accessory_sales) +
        brand_sales.sum(:game_sales)
      share_obj = {
        name: brand.name,
        sales_amount: sales_amount,
        share_percentage: total_sales > 0 ? sales_amount.to_f/total_sales.to_f : 0
      }
      share_percentages << share_obj
      hardware = 0
      accessories = 0
      games = 0

      company_sales = {
        name: brand.name,
        sales_by_type: {
          hardware: brand_sales.sum(:hardware_sales),
          accessories: brand_sales.sum(:accessory_sales),
          games: brand_sales.sum(:game_sales)
        }
      }
      sales_by_company << company_sales

    end


    product_sales = DailyProductSale.joins(:store).where("sales_date >= ? AND sales_date < ?", sales_date, end_date)


    if params[:store_id].present?
      product_sales = product_sales.where(store_id: params[:store_id].to_i)
    end

    if params[:dealer_id].present?
      product_sales = product_sales.where(stores: { dealer_id: params[:dealer_id].to_i })
    end

    if params[:instructor_id].present?
      product_sales = product_sales.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      product_sales = product_sales.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      product_sales = product_sales.where(stores: { zone_id: params[:zone_id].to_i })
    end

    grouped_products = product_sales.group_by(&:product).map do |key, val|
      { 
        name: key.name,
        quantity: val.inject(0) { |sum, x| sum + x.quantity},
        sales_amount: 0
      }
    end
    
    grouped_products.sort! do |a, b|
      b[:quantity] <=> a[:quantity]
    end    
    grouped_products = grouped_products[0..8]

    best_practices = Image.where("created_at >= ? AND created_at < ?", sales_date, end_date)
      .order("created_at DESC")
      .limit(10)
      .map { |image| image.image.url }

    data = {
      sales_by_zone: sales_by_zone,
      share_percentages: share_percentages,
      sales_by_company: sales_by_company,
      year: year,
      month: month,
      id: sales_date,
      top_products: grouped_products,
      best_practices: best_practices
    }
    report = SalesReport.new data


    render json: JSONAPI::ResourceSerializer.new(Api::V1::SalesReportResource)
    .serialize_to_hash(Api::V1::SalesReportResource.new(report, nil))
  end

  def best_practices
    month = params.require(:month)
    year = params.require(:year)
    sales_date = DateTime.new(year.to_i, month.to_i)
    end_date = sales_date + 1.month
  end

end
