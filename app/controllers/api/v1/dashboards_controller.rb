class Api::V1::DashboardsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

  def filtered_reports
    reports = Report.joins(:store)
    .where("reports.created_at > ? AND reports.created_at < ?", @start_date, @end_date)

    if params[:store_id].present?
      reports = reports.where(store_id: params[:store_id].to_i )
    end

    if params[:dealer_id].present?
      reports = reports.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      reports = reports.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      reports = reports.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      reports = reports.where(stores: { zone_id: params[:zone_id].to_i })
    end
    reports
  end

  def filtered_head_counts
    head_counts = DailyHeadCount.joins(:store)
    .where("daily_head_counts.created_at > ? AND daily_head_counts.created_at < ?", @start_date, @end_date)

    head_counts
  end

  def filtered_checkins
    checkins = Checkin.joins(:store)
    .where("checkins.arrival_time >= ? AND checkins.arrival_time < ? AND checkins.exit_time is not null AND DATE(checkins.exit_time) = DATE(checkins.arrival_time)",
      @start_date, @end_date)

    if params[:store_id].present?
      checkins = checkins.where(store_id: params[:store_id].to_i )
    end

    if params[:dealer_id].present?
      checkins = checkins.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      checkins = checkins.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      checkins = checkins.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      checkins = checkins.where(stores: { zone_id: params[:zone_id].to_i })
    end
    checkins
  end

  def group_by_day(collection, criteria, &block)
    groups = collection.group_by(&criteria).map(&block).sort
    current_index = 0
    filled_in_groups = []

    @days_in_month.times do |i|
      if groups[current_index] && groups[current_index][0].day == (i + 1)
        filled_in_groups << groups[current_index]
        current_index += 1
      else
        date = DateTime.new(@year.to_i, @month.to_i, (i + 1)).to_date
        if @current_date > date
          new_day = [ date, 0 ]
        else
          new_day = [ date, -1 ]
        end
        filled_in_groups << new_day
      end
    end

    groups = filled_in_groups

    by_day = groups.map do |group|
      {
        week_day: I18n.l(group[0], format: '%A').capitalize,
        month_day: group[0].day,
        amount: group[1]
      }
    end
    {
      groups: groups,
      by_day: by_day 
    }
  end

  def get_accumulated(shortened_groups, accumulated = true)
    if DateTime.now < @end_date
      shortened_groups = shortened_groups[0..(DateTime.now.day - 1)]
    end

    shortened_groups.each_with_index.map do |e, i|
      sum = shortened_groups[0..i].inject(0) do |memo, obj|
        if not accumulated
          obj[1]
        elsif obj[1] >= 0
          obj[1] + memo
        else
          memo
        end
      end
      [ e[0].day, sum ]
    end
  end

  def promoter_activity
    
    @month = params.require(:month)
    @year = params.require(:year)
    @start_date = DateTime.new(@year.to_i, @month.to_i)
    @end_date = @start_date + 1.month
    @days_in_month = @start_date.end_of_month.day
    @current_date = DateTime.now

    reports = filtered_reports
    grouped = group_by_day(reports, :group_by_date_criteria) {|k,v| [k, v.length]}
    reports_by_day = grouped[:by_day]
    accumulated_reports = get_accumulated(grouped[:groups])

    checkins = filtered_checkins
    grouped_checkins = group_by_day(checkins, :group_by_date_criteria) {|k,v| [k, v.length]}
    checkins_by_day = grouped_checkins[:by_day]
    accumulated_checkins = get_accumulated(grouped_checkins[:groups], false)

    grouped_hours = group_by_day(checkins, :group_by_date_criteria) do |k, v|
      [ 
        k, v.inject(0) do |sum, x|
          sum + ((x.exit_time-x.arrival_time)/1.hour).round
        end
      ]
    end
    hours_by_day = grouped_hours[:by_day]
    accumulated_hours = get_accumulated(grouped_hours[:groups], false)

    dealer_counts = filtered_head_counts.group_by(&:group_by_dealer_criteria)
    head_counts = []
    dealer_ids = []
    dealer_counts.each do |key, val|
      
      brands = []
      brand_groups = val.group_by(&:brand)

      brand_groups.each do |brand, brand_counts|
        brand_obj = {
          name: brand.name,
          num_full_time: brand_counts.inject(0) {|sum,x| sum + x.num_full_time },
          num_part_time: brand_counts.inject(0) {|sum,x| sum + x.num_part_time }
        }
        
        brands << brand_obj
      end
      dealer_obj = {
        name: key.name,
        brands: brands
      }
      dealer_ids << key.id
      head_counts << dealer_obj
    end


    Dealer.where.not(id: dealer_ids).each do |dealer|
      brands = []
      Brand.all.each do |brand|
        brands << {
          name: brand.name,
          num_full_time: 0,
          num_part_time: 0
        }
      end
      dealer_obj = {
        name: dealer.name,
        brands: brands
      }
      head_counts << dealer_obj
    end

    head_counts.sort! { |a, b| a[:name] <=> b[:name] }
    
    head_counts_by_store = []
    store_ids = []

    if params[:dealer_id]
      specific_counts = filtered_head_counts.where(stores: { dealer_id: params[:dealer_id].to_i } )
      store_counts = specific_counts.group_by(&:group_by_store_criteria)

      store_counts.each do |key, val|
        brands = []
        brand_groups = val.group_by(&:brand)

        brand_groups.each do |brand, brand_counts|
          brand_obj = {
            name: brand.name,
            num_full_time: brand_counts.inject(0) {|sum,x| sum + x.num_full_time },
            num_part_time: brand_counts.inject(0) {|sum,x| sum + x.num_part_time }
          }
          
          brands << brand_obj
        end
        store_obj = {
          name: key.name,
          brands: brands
        }
        store_ids << key.id
        head_counts_by_store << store_obj
      end

      dealer_stores = Dealer.find(params[:dealer_id]).stores.where.not(id: store_ids)
      if params[:zone_id].present?
        dealer_stores = dealer_stores.where(stores: { zone_id: params[:zone_id ]})
      end
      if params[:instructor_id].present?
        dealer_stores = dealer_stores.where(stores: { instructor_id: params[:instructor_id ]})
      end
      if params[:supervisor_id].present?
        dealer_stores = dealer_stores.where(stores: { supervisor_id: params[:supervisor_id ]})
      end

      dealer_stores.each do |store|
        brands = []
        Brand.all.each do |brand|
          brands << {
            name: brand.name,
            num_full_time: 0,
            num_part_time: 0
          }
        end
        store_obj = {
          name: store.name,
          brands: brands
        }
        head_counts_by_store << store_obj
      end

      head_counts_by_store.sort! { |a, b| a[:name] <=> b[:name] }

    end

    images = Image.joins(report: :store).
      where("category_id = ? AND reports.created_at >= ? AND reports.created_at < ?", 3, @start_date, @end_date)


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
    .limit(10)
    .map { |image| image.image.url }

    data = {
      id: @start_date,
      year: @year,
      month: @month,
      reports_by_day: reports_by_day,
      accumulated_reports: accumulated_reports,
      checkins_by_day: checkins_by_day,
      accumulated_checkins: accumulated_checkins,
      hours_by_day: hours_by_day,
      accumulated_hours: accumulated_hours,
      head_counts: head_counts,
      best_practices: best_practices,
      head_counts_by_store: head_counts_by_store
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
    grouped_products = grouped_products[0..7]


    data = {
      sales_by_zone: sales_by_zone,
      share_percentages: share_percentages,
      sales_by_company: sales_by_company,
      year: year,
      month: month,
      id: sales_date,
      top_products: grouped_products
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

    images = Image.joins(report: :store).
      where("category_id = ? AND reports.created_at >= ? AND reports.created_at < ?", 3, sales_date, end_date)


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

    image_urls = images
    .order("created_at DESC")
    .map { |image| image.image.url }

    data = {
      id: sales_date,
      image_urls: image_urls
    }

    practices = BestPractices.new(data)

    render json: JSONAPI::ResourceSerializer.new(Api::V1::BestPracticesResource)
    .serialize_to_hash(Api::V1::BestPracticesResource.new(practices, nil))

  end

end
