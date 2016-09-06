# -*- encoding : utf-8 -*-
class Api::V1::DashboardsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  before_action :parse_dates

  def parse_dates
    @month = params.require(:month)
    @year = params.require(:year)
    @start_day = params[:start_day] || 1

    @sales_date = DateTime.new(@year.to_i, @month.to_i, @start_day.to_i)
    @start_date = @sales_date
    @end_day = params[:end_day]

    if @end_day.present?
      @end_date = DateTime.new(@year.to_i, @month.to_i, @end_day.to_i).end_of_day
    else
      @end_date = @start_date.end_of_month
    end
  end

  def filtered_reports(start_date = @start_date, end_date = @end_date)
    reports = Report.unassigned
    .joins(:store)
    .where("reports.created_at >= ? AND reports.created_at < ?", start_date, end_date)
    .where(finished: true)

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

  def filtered_stock_breaks(start_date = @start_date, end_date = @end_date)
    stock_breaks = StockBreakEvent.joins(report: :store)
    .merge(Report.unassigned)
    .where("stock_break_date >= ? AND stock_break_date < ?", start_date, end_date)

    if params[:store_id].present?
      stock_breaks = stock_breaks.where(reports: { store_id: params[:store_id].to_i })
    end

    if params[:dealer_id].present?
      stock_breaks = stock_breaks.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      stock_breaks = stock_breaks.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      stock_breaks = stock_breaks.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      stock_breaks = stock_breaks.where(stores: { zone_id: params[:zone_id].to_i })
    end
    stock_breaks
  end

  def goals_xlsx
    package = Axlsx::Package.new
    current_year = DateTime.now.year

    excel_classes = [
      WeeklyBusinessSale.where("month >= ? AND month <= ?",
                               DateTime.now.beginning_of_year - 1.year, DateTime.now.end_of_year - 1.year)
      .order("week_start ASC"),
      WeeklyBusinessSale.where("month >= ? AND month <= ?",
                               DateTime.now.beginning_of_year, DateTime.now.end_of_year)
      .order("week_start ASC"),
      SaleGoal.where("goal_date >= ? AND goal_date <= ?",
                     DateTime.now.beginning_of_year - 1.year,
                     DateTime.now.end_of_year)
      .order("goal_date ASC")
    ]
    excel_classes[0].to_xlsx package: package, name: "Ventas #{current_year - 1}"
    excel_classes[1].to_xlsx package: package, name: "Ventas #{current_year}"
    excel_classes[2].to_xlsx package: package, name: "Metas #{current_year - 1} - #{current_year}"

    render text: package.to_stream.read
  end

  def goals
    if params[:format] == "xlsx"
      goals_xlsx
      return
    end

    @days_in_month = @start_date.end_of_month.day
    @current_date = DateTime.now


    goals_by_dealer = filtered_monthly_goals
    .includes(store: :dealer)
    .group_by(&:dealer_criteria)

    dealer_ids = goals_by_dealer.map { |g| g[0].id }
    sales_by_dealer = filtered_weekly_sales_by_month
    .includes(store: :dealer)
    .where(
      stores: { dealer_id: dealer_ids }
    )
    .group_by(&:dealer_criteria)

    monthly_sales_vs_goals = goals_by_dealer.map do |goal|
      sales = sales_by_dealer.find(ifnone = nil) { |d| d[0].id == goal[0].id }
      sales_amount = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end
      goal_amount = goal[1].inject(0) do |sum, x|
        sum + x.monthly_goal
      end
      {
        name: goal[0].name,
        goal: goal_amount,
        sales: sales_amount,
        goal_percentage: sales_amount.to_f/goal_amount.to_f
      }
    end

    newest_sales_week = WeeklyBusinessSale.maximum(:week_start)
    current_week_of_year = newest_sales_week.strftime("%U").to_i
    current_year = newest_sales_week.year

    last_week_sales = filtered_weekly_sales_by_week(Date.commercial(current_year, current_week_of_year) - 1.week, Date.commercial(current_year, current_week_of_year))
    .includes(store: :dealer)
    .group_by(&:dealer_criteria)

    current_week_sales_data = filtered_weekly_sales_by_week(Date.commercial(current_year, current_week_of_year), DateTime.now)
    .includes(store: :dealer)
    .group_by(&:dealer_criteria)


    last_week_comparison = last_week_sales.map do |weekly_sales|

      sales = current_week_sales_data.find(ifnone = nil) do |d|
        d[0].id == weekly_sales[0].id
      end
      current_week_sales = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end
      last_week_sales = weekly_sales[1].inject(0) do |sum, x|
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end
      {
        name: weekly_sales[0].name,
        last_week_sales: last_week_sales,
        current_week_sales: current_week_sales,
        growth_percentage: last_week_sales > 0 ? ((current_week_sales.to_f - last_week_sales.to_f)/last_week_sales.to_f) : nil
      }
    end
    
    selected_date = DateTime.new(@year.to_i, @month.to_i)
    last_year_weekly_sales = filtered_weekly_sales_by_month(selected_date.beginning_of_month - 1.year, selected_date.end_of_month - 1.year).group_by(&:week_criteria)
    current_year_weekly_sales = filtered_weekly_sales_by_month(selected_date.beginning_of_month, selected_date.end_of_month).group_by(&:week_criteria)
    first_month_week = selected_date.beginning_of_month.strftime("%U").to_i
    last_month_week = selected_date.end_of_month.strftime("%U").to_i
    iterations = last_month_week - first_month_week
    iterations.times do |i|

      if not last_year_weekly_sales[i + first_month_week].present?
        last_year_weekly_sales[i + first_month_week] = []
      end
      if not current_year_weekly_sales[i + first_month_week].present?
        current_year_weekly_sales[i + first_month_week] = []
      end
    end

    weekly_sales_comparison = last_year_weekly_sales.map do |weekly_sales|
      
      last_year_sales = weekly_sales[1].inject(0) do |sum, x|
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end
      
      current_year_sales = current_year_weekly_sales[weekly_sales[0]]
      .inject(0) do |sum, x|
        
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end
      {
        week: "Semana #{weekly_sales[0]}",
        week_number: weekly_sales[0],
        last_year_sales: last_year_sales,
        current_year_sales: current_year_sales,
        growth_percentage: last_year_sales > 0 ? ((current_year_sales.to_f - last_year_sales.to_f)/last_year_sales.to_f) : nil
      }
    end
    weekly_sales_comparison.sort! do |w1, w2|
      w1[:week_number] - w2[:week_number]
    end


    last_year_monthly_sales = filtered_weekly_sales_by_month(DateTime.now.beginning_of_year - 1.year, DateTime.now.end_of_year - 1.year).group_by(&:month_criteria)
    current_year_monthly_sales = filtered_weekly_sales_by_month(DateTime.now.beginning_of_year, DateTime.now.end_of_year).group_by(&:month_criteria)

    12.times do |i|
      if not last_year_monthly_sales[i + 1].present?
        last_year_monthly_sales[i + 1] = []
      end
      if not current_year_monthly_sales[i + 1].present?
        current_year_monthly_sales[i + 1] = []
      end
    end

    monthly_sales_comparison = last_year_monthly_sales.map do |monthly_sales|

      last_year_sales = monthly_sales[1].inject(0) do |sum, x|
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end

      current_year_sales = current_year_monthly_sales[monthly_sales[0]]
      .inject(0) do |sum, x|

        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end

      {
        month: I18n.t("date.month_names")[monthly_sales[0]][0..2].capitalize,
        month_index: monthly_sales[0],
        last_year_sales: last_year_sales,
        current_year_sales: current_year_sales,
        growth_percentage: last_year_sales > 0 ? ((current_year_sales.to_f - last_year_sales.to_f)/last_year_sales.to_f) : nil
      }
    end

    
    monthly_sales_comparison.sort! do |m1, m2|
      m1[:month_index] - m2[:month_index]
    end

    

    data = {
      id: @start_date,
      last_week_of_year: current_week_of_year - 1,
      current_week_of_year: current_week_of_year,
      current_year: current_year,
      last_year: current_year - 1,
      monthly_sales_vs_goals: monthly_sales_vs_goals,
      last_week_comparison: last_week_comparison,
      monthly_sales_comparison: monthly_sales_comparison,
      weekly_sales_comparison: weekly_sales_comparison

    }

    goal_dashboard = GoalDashboard.new data

     

    render json: JSONAPI::ResourceSerializer.new(Api::V1::GoalDashboardResource)
    .serialize_to_hash(Api::V1::GoalDashboardResource.new(goal_dashboard, nil))

  end

  def filtered_monthly_goals(start_date = @start_date, end_date = @end_date)
    sale_goals = SaleGoal.joins(:store)
    .where("goal_date >= ? AND goal_date < ? AND monthly_goal > ?", start_date.beginning_of_month, end_date.end_of_month, 0)

    if params[:store_id].present?
      sale_goals = sale_goals.where(store_id: params[:store_id].to_i )
    end

    if params[:dealer_id].present?
      sale_goals = sale_goals.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      sale_goals = sale_goals.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      sale_goals = sale_goals.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      sale_goals = sale_goals.where(stores: { zone_id: params[:zone_id].to_i })
    end
    sale_goals
  end

  def filtered_weekly_sales_by_week(start_date = @start_date, end_date = @end_date)
    weekly_sales = WeeklyBusinessSale.joins(:store)
    .where("week_start = ?", start_date)

    if params[:store_id].present?
      weekly_sales = weekly_sales.where(store_id: params[:store_id].to_i )
    end

    if params[:dealer_id].present?
      weekly_sales = weekly_sales.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      weekly_sales = weekly_sales.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      weekly_sales = weekly_sales.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      weekly_sales = weekly_sales.where(stores: { zone_id: params[:zone_id].to_i })
    end
    weekly_sales
  end

  def filtered_weekly_sales_by_month(start_date = @start_date, end_date = @end_date)
    weekly_sales = WeeklyBusinessSale.joins(:store)
    .where("month >= ? AND month < ?", start_date.beginning_of_month, end_date.end_of_month)

    if params[:store_id].present?
      weekly_sales = weekly_sales.where(store_id: params[:store_id].to_i )
    end

    if params[:dealer_id].present?
      weekly_sales = weekly_sales.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      weekly_sales = weekly_sales.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      weekly_sales = weekly_sales.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      weekly_sales = weekly_sales.where(stores: { zone_id: params[:zone_id].to_i })
    end
    weekly_sales
  end

  def stock_xlsx
    package = Axlsx::Package.new
    excel_classes = [ StockBreakEvent.joins(:report)
      .includes(report: [{ store: [ :dealer, :zone, :instructor, :supervisor]}, :creator, :assigned_user])
      .includes(product: :product_classification)
      .order("reports.created_at DESC") ]
    excel_classes.each do |model_class|
      model_class.to_xlsx(package: package)
    end
    render text: package.to_stream.read
  end

  def stock
    if params[:format] == "xlsx"
      stock_xlsx
      return
    end
  
    @days_in_month = @start_date.end_of_month.day
    @current_date = DateTime.now

    stock_breaks = []
    filtered_stock_breaks.includes(report: { store: :dealer })
    .includes(:product)
    .group_by(&:group_by_store_criteria).each do |store, group|
      if group.length > 0
        stock_break = group.max { |a, b| a.stock_break_date <=> b.stock_break_date }
        product = stock_break.product
        stock_breaks << {
          ean: product.sku,
          description: product.name,
          classification: product.product_classification.name,
          platform: product.platform.name,
          publisher: product.publisher,
          category: product.product_type.name,
          units: stock_break.quantity,
          store_name: stock_break.store.name,
          dealer_name: stock_break.store.dealer.name
        }
      end
    end
    
    stock_breaks.sort! { |a, b| a[:store_name] <=> b[:store_name] }

    product_sales = DailyProductSale.joins(report: :store)
    .merge(Report.unassigned)
    .where("reports.created_at >= ? AND reports.created_at <= ? AND quantity > ?", @start_date, @end_date, 0)


    if params[:store_id].present?
      product_sales = product_sales.where(reports: { store_id: params[:store_id].to_i })
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

    grouped_products = product_sales
    .includes(product: [:platform, :product_type, :product_classification])
    .includes(report: { store: :dealer })
    .group_by(&:product_store_criteria).map do |key, val|
      {
        ean: key[0].sku,
        description: key[0].name,
        classification: key[0].product_classification.name,
        platform: key[0].platform.name,
        publisher: key[0].publisher,
        category: key[0].product_type.name,
        units: val.inject(0) { |sum, x| sum + x.quantity},
        store_name: key[1].name,
        dealer_name: key[1].dealer.name,
        sales_amount: 0
      }
    end

    grouped_products.sort! do |a, b|
      b[:units] <=> a[:units]
    end

    data = {
      id: @start_date,
      top_products: grouped_products,
      stock_breaks: stock_breaks
    }

    stock_dashboard = StockDashboard.new data

    render json: JSONAPI::ResourceSerializer.new(Api::V1::StockDashboardResource)
    .serialize_to_hash(Api::V1::StockDashboardResource.new(stock_dashboard, nil))
  end

  def filtered_checklist_values(start_date = @start_date, end_date = @end_date, checklist_item_id)

    items = ChecklistItemValue.joins(report: :store)
    .merge(Report.unassigned)
    .where("reports.created_at > ? AND reports.created_at < ? AND data_part_id = ?", start_date, end_date, checklist_item_id)

    if params[:store_id].present?
      items = items.where(reports: { store_id: params[:store_id].to_i })
    end

    if params[:dealer_id].present?
      items = items.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      items = items.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      items = items.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      items = items.where(stores: { zone_id: params[:zone_id].to_i })
    end
    items
  end

  def filtered_head_counts(start_date = @start_date, end_date = @end_date)
    head_counts = DailyHeadCount
    .select('distinct on (daily_head_counts.count_date, reports.store_id, daily_head_counts.brand_id) daily_head_counts.*')
    .joins(report: :store)
    .merge(Report.unassigned)
    .where("daily_head_counts.created_at > ? AND daily_head_counts.created_at < ?", start_date, end_date)
    .order('daily_head_counts.count_date, reports.store_id, daily_head_counts.brand_id, reports.created_at DESC')

    if params[:store_id].present?
      head_counts = head_counts.where(reports: { store_id: params[:store_id].to_i })
    end

    if params[:dealer_id].present?
      head_counts = head_counts.where(stores: { dealer_id: params[:dealer_id].to_i } )
    end

    if params[:instructor_id].present?
      head_counts = head_counts.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      head_counts = head_counts.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      head_counts = head_counts.where(stores: { zone_id: params[:zone_id].to_i })
    end

    head_counts
  end

  def filtered_checkins(start_date = @start_date, end_date = @end_date)
    checkins = Checkin.joins(:store)
    .where("checkins.arrival_time >= ? AND checkins.arrival_time < ? AND checkins.exit_time is not null AND DATE(checkins.exit_time) = DATE(checkins.arrival_time)",
           start_date, end_date)

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

  def group_checklist_by_day(collection, criteria, &block)
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
          new_day = [ date, 0, 0 ]
        else
          new_day = [ date, -1, -1 ]
        end
        filled_in_groups << new_day
      end
    end

    groups = filled_in_groups
    by_day = groups.map do |group|
      {
        week_day: I18n.l(group[0], format: '%A').capitalize,
        month_day: group[0].day,
        num_total: group[1],
        num_fulfilled: group[2]
      }
    end
    {
      groups: groups,
      by_day: by_day
    }
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

      sum = shortened_groups[0..i].inject(Array.new(e.size - 1) { |i| 0 }) do |memo, obj|
        if not accumulated
          obj[1..obj.length-1]
        elsif obj[1] >= 0

          [obj[1..obj.length-1], memo].transpose.map {|x| x.reduce(:+)}
        else
          memo
        end
      end
      [ e[0].day ] + sum
    end
  end

  def promoter_activity_xlsx
    package = Axlsx::Package.new
    excel_classes = [ Report
      .includes(store: [:zone, :dealer, :instructor, :supervisor])
      .includes(:creator, :assigned_user, :report_type, :checklist_item_values)
      .where(finished: true).
      order("created_at DESC"),
    Checkin.includes(store: [ :zone, :dealer ])
      .includes(:user)
      .order('arrival_time DESC'),
      DailyHeadCount
      .includes(report: [{ store: [ :zone, :dealer, :instructor, :supervisor ]}, :creator, :assigned_user])      
      .includes(:brand)
      .order("count_date DESC")]
    excel_classes.each do |model_class|
      model_class.to_xlsx(package: package)
    end
    render text: package.to_stream.read
  end

  def promoter_activity

    if params[:format] == "xlsx"
      promoter_activity_xlsx
      return
    end

    @days_in_month = @start_date.end_of_month.day
    @current_date = DateTime.now

    reports = filtered_reports
    num_reports_today = filtered_reports(@current_date.beginning_of_day, @current_date).count
    num_reports_yesterday = filtered_reports(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day).count
    grouped = group_by_day(reports, :group_by_date_criteria) {|k,v| [k, v.length]}
    reports_by_day = grouped[:by_day]
    accumulated_reports = get_accumulated(grouped[:groups], false)
    checkins = filtered_checkins
    grouped_checkins = group_by_day(checkins, :group_by_date_criteria) {|k,v| [k, v.length]}
    num_checkins_today = filtered_checkins(@current_date.beginning_of_day, @current_date).count
    num_checkins_yesterday = filtered_checkins(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day).count

    checkins_by_day = grouped_checkins[:by_day]
    accumulated_checkins = get_accumulated(grouped_checkins[:groups], false)

    grouped_hours = group_by_day(checkins, :group_by_date_criteria) do |k, v|


      [
        k, ((v.inject(0) do |sum, x|
               sum + (x.exit_time-x.arrival_time)
            end)/1.hour).round
        ]
        end
        hours_by_day = grouped_hours[:by_day]
        accumulated_hours = get_accumulated(grouped_hours[:groups], false)
        num_hours_today = filtered_checkins(@current_date.beginning_of_day, @current_date).inject(0) do |sum, x|
          sum + (x.exit_time-x.arrival_time)
        end
        num_hours_today = (num_hours_today/1.hour).round
        num_hours_yesterday = filtered_checkins(@current_date.beginning_of_day - 1.day,
        @current_date.beginning_of_day).inject(0) do |sum, x|
          sum + (x.exit_time-x.arrival_time)
        end
        num_hours_yesterday = (num_hours_yesterday/1.hour).round

        dealer_counts = filtered_head_counts
        .includes(report: { store: :dealer })
        .includes(:brand)
        .group_by(&:group_by_dealer_criteria)
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

        if params[:dealer_id].present? or params[:store_id].present?
          specific_counts = filtered_head_counts
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

          if params[:store_id].present?
            store = Store.find(params[:store_id])
            dealer_stores = store.dealer.stores.where.not(id: store_ids)
          elsif params[:dealer_id].present?
            dealer_stores = Dealer.find(params[:dealer_id]).stores.where.not(id: store_ids)
          end

          if params[:zone_id].present?
            dealer_stores = dealer_stores.where(stores: { zone_id: params[:zone_id ]})
          end
          if params[:instructor_id].present?
            dealer_stores = dealer_stores.where(stores: { instructor_id: params[:instructor_id ]})
          end
          if params[:supervisor_id].present?
            dealer_stores = dealer_stores.where(stores: { supervisor_id: params[:supervisor_id ]})
          end

          if not params[:store_id].present?
            dealer_stores.each do |dealer_store|
              brands = []
              Brand.all.each do |brand|
                brands << {
                  name: brand.name,
                  num_full_time: 0,
                  num_part_time: 0
                }
              end
              store_obj = {
                name: dealer_store.name,
                brands: brands
              }
              head_counts_by_store << store_obj
            end
          end

          head_counts_by_store.sort! { |a, b| a[:name] <=> b[:name] }

        end

        communicated_values_month = filtered_checklist_values(checklist_item_id = 144)
        communicated_values_today = filtered_checklist_values(@current_date.beginning_of_day, @current_date, 144)
        communicated_values_yesterday = filtered_checklist_values(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day, 144)
        percent_prices_communicated_today =
        communicated_values_today.count > 0 ? communicated_values_today.where(item_value: true).count.to_f/communicated_values_today.count.to_f : -1
        percent_prices_communicated_yesterday =
        communicated_values_yesterday.count > 0  ? communicated_values_yesterday.where(item_value: true).count.to_f/communicated_values_yesterday.count.to_f : -1


        communicated_prices = []
        communicated_values_month
        .includes(report: :store)
        .order('reports.created_at DESC')
        .group_by(&:group_by_store_criteria).each do |key, val|
          if val.length > 0
            checklist = val[0]
            if not checklist.item_value
              store_hash = {
                zone_name: key.zone.name,
                dealer_name: key.dealer.name,
                store_name: key.name,
                instructor_name: key.instructor.present? ? key.instructor.name : "Sin instructor",
                supervisor_name: key.supervisor.present? ? key.supervisor.name : "Sin supervisor",
                pdf: checklist.report.pdf_url
              }
              communicated_prices << store_hash
            end
          end
        end
        communicated_prices.sort! { |a,b| a["store_name"] <=> b["store_name"]}
        grouped_prices = group_checklist_by_day(communicated_values_month.includes(:report), :group_by_date_criteria) do |k, v|
          [
            k,
            v.inject(0) { |sum, x | x.item_value ? sum + 1 : sum },
            v.length
          ]
        end


        prices_by_day = grouped_prices[:by_day]
        accumulated_prices = get_accumulated(grouped_prices[:groups], false)

        communicated_promotions_month = filtered_checklist_values(checklist_item_id = 145)
        communicated_promotions_today = filtered_checklist_values(@current_date.beginning_of_day, @current_date, 145)
        communicated_promotions_yesterday = filtered_checklist_values(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day, 145)
        percent_promotions_communicated_today =
        communicated_promotions_today.count > 0 ? communicated_promotions_today.where(item_value: true).count.to_f/communicated_promotions_today.count.to_f : -1
        percent_promotions_communicated_yesterday =
        communicated_promotions_yesterday.count > 0  ? communicated_promotions_yesterday.where(item_value: true).count.to_f/communicated_promotions_yesterday.count.to_f : -1

        communicated_promotions_by_store = []

        filtered_checklist_values(checklist_item_id = 145)
        .order('reports.created_at DESC')
        .includes(report: { store: [ :dealer, :zone ] })
        .group_by(&:group_by_store_criteria).each do |key, val|
          if val.length > 0
            checklist = val[0]
            if not checklist.item_value
              store_hash = {
                zone_name: key.zone.name,
                dealer_name: key.dealer.name,
                store_name: key.name,
                instructor_name: key.instructor.present? ? key.instructor.name : "Sin instructor",
                supervisor_name: key.supervisor.present? ? key.supervisor.name : "Sin supervisor",
                pdf: checklist.report.pdf_url
              }
              communicated_promotions_by_store << store_hash
            end
          end
        end
        communicated_promotions_by_store.sort! { |a,b| a["store_name"] <=> b["store_name"]}
        grouped_promotions = group_checklist_by_day(communicated_promotions_month.includes(:report), :group_by_date_criteria) do |k, v|
          [
            k,
            v.inject(0) { |sum, x | x.item_value ? sum + 1 : sum },
            v.length
          ]
        end

        promotions_by_day = grouped_promotions[:by_day]
        accumulated_promotions = get_accumulated(grouped_promotions[:groups], false)


        data = {
          id: @start_date,
          year: @year,
          month: @month,
          reports_by_day: reports_by_day,
          num_reports_yesterday: num_reports_yesterday,
          num_reports_today: num_reports_today,
          accumulated_reports: accumulated_reports,
          checkins_by_day: checkins_by_day,
          num_checkins_yesterday: num_checkins_yesterday,
          num_checkins_today: num_checkins_today,
          accumulated_checkins: accumulated_checkins,
          hours_by_day: hours_by_day,
          accumulated_hours: accumulated_hours,
          num_hours_yesterday: num_hours_yesterday,
          num_hours_today: num_hours_today,
          head_counts: head_counts,
          head_counts_by_store: head_counts_by_store,
          percent_prices_communicated_yesterday: percent_prices_communicated_yesterday,
          percent_prices_communicated_today: percent_prices_communicated_today,
          communicated_prices_by_store: communicated_prices,
          prices_by_day: prices_by_day,
          accumulated_prices: accumulated_prices,
          percent_promotions_communicated_yesterday: percent_promotions_communicated_yesterday,
          percent_promotions_communicated_today: percent_promotions_communicated_today,
          communicated_promotions_by_store: communicated_promotions_by_store,
          promotions_by_day: promotions_by_day,
          accumulated_promotions: accumulated_promotions
        }

        promoter_activity = PromoterActivity.new data

        render json: JSONAPI::ResourceSerializer.new(Api::V1::PromoterActivityResource)
        .serialize_to_hash(Api::V1::PromoterActivityResource.new(promoter_activity, nil))

        end

        def sales_xlsx
          package = Axlsx::Package.new

          excel_classes = [ filtered_product_sales
                            .includes(report: [{ store: [ :dealer, :zone, :supervisor, :instructor ]}, :creator, :assigned_user])
                            .includes(product: :product_classification)
                            .order("reports.created_at DESC"),
                            filtered_daily_sales
                            .includes(report: [{store: [ :dealer, :zone, :supervisor, :instructor ]}, :creator, :assigned_user])
                            .includes(:brand)
                            ]
          excel_classes.each do |model_class|
            model_class.to_xlsx(package: package)
          end
          render text: package.to_stream.read

        end

        def filtered_product_sales(start_date = @start_date, end_date = @end_date)
          product_sales =
            DailyProductSale.joins(report: :store)
          .merge(Report.unassigned)
          .where("reports.created_at >= ? AND reports.created_at <= ?", start_date, end_date)
          if params[:store_id].present?
            product_sales = product_sales.where(reports: { store_id: params[:store_id].to_i })
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
          product_sales
        end


        def filtered_daily_sales(start_date = @start_date, end_date = @end_date)
          daily_sales =
            DailySale.select('DISTINCT ON(reports.store_id, brand_id, extract(month from reports.created_at)) daily_sales.*')
          .joins(report: :store)
          .merge(Report.unassigned)
          .where("reports.created_at >= ? AND reports.created_at <= ?", start_date, end_date)
          .order('reports.store_id, brand_id, extract(month from reports.created_at), reports.created_at DESC')

          if params[:store_id].present?
            daily_sales = daily_sales.where(reports: { store_id: params[:store_id].to_i })
          end

          if params[:dealer_id].present?
            daily_sales = daily_sales.where(stores: { dealer_id: params[:dealer_id].to_i })
          end

          if params[:instructor_id].present?
            daily_sales = daily_sales.where(stores: { instructor_id: params[:instructor_id].to_i })
          end

          if params[:supervisor_id].present?
            daily_sales = daily_sales.where(stores: { supervisor_id: params[:supervisor_id].to_i })
          end

          if params[:zone_id].present?
            daily_sales = daily_sales.where(stores: { zone_id: params[:zone_id].to_i })
          end
          daily_sales
        end

        def sales
          if params[:format] == "xlsx"
            sales_xlsx
            return
          end

          sales = filtered_daily_sales

          sales_by_zone = [
          ]

          hardware_sales = sales.inject(0) { |sum, x| sum + x.hardware_sales }
          accessory_sales = sales.inject(0) { |sum, x| sum + x.accessory_sales }
          game_sales = sales.inject(0) { |sum, x| sum + x.game_sales }

          total_sales = hardware_sales + accessory_sales + game_sales

          Zone.all.each do |zone|

            zone_sales = sales.where(stores: { zone_id: zone.id })
            num_zone_sales = zone_sales.inject(0) { |sum, x| sum + x.hardware_sales } +
              zone_sales.inject(0) { |sum, x| sum + x.accessory_sales } +
              zone_sales.inject(0) { |sum, x| sum + x.game_sales }


            brands_array = [
            ]
            Brand.all.each do |brand|
              brand_sales = zone_sales.where(brand: brand)
              sales_amount = brand_sales.inject(0) { |sum, x| sum + x.hardware_sales } +
                brand_sales.inject(0) { |sum, x| sum + x.accessory_sales } +
                brand_sales.inject(0) { |sum, x| sum + x.game_sales }

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

          share_percentages = [

          ]

          sales_by_company = [

          ]

          Brand.all.each do |brand|
            brand_sales = sales.where(brand: brand)
            sales_amount = brand_sales.inject(0) { |sum, x| sum + x.hardware_sales } +
              brand_sales.inject(0) { |sum, x| sum + x.accessory_sales } +
              brand_sales.inject(0) { |sum, x| sum + x.game_sales }
            share_obj = {
              name: brand.name,
              sales_amount: sales_amount,
              share_percentage: total_sales > 0 ? sales_amount.to_f/total_sales.to_f : 0
            }
            share_percentages << share_obj

            brand_hardware_sales = brand_sales.inject(0) { |sum, x| sum + x.hardware_sales }
            brand_accessory_sales = brand_sales.inject(0) { |sum, x| sum + x.accessory_sales }
            brand_game_sales = brand_sales.inject(0) { |sum, x| sum + x.game_sales }

            company_sales = {
              name: brand.name,
              sales_by_type: {
                hardware: brand_hardware_sales,
                accessories: brand_accessory_sales,
                games: brand_game_sales,
                total: brand_hardware_sales + brand_accessory_sales + brand_game_sales
              }
            }
            sales_by_company << company_sales

          end


          product_sales = filtered_product_sales.includes(product: [ :platform, :product_type ])


          grouped_products = product_sales.group_by(&:product).map do |key, val|
            {
              name: key.name,
              category: key.product_type.name,
              quantity: val.inject(0) { |sum, x| sum + x.quantity},
              sales_amount: 0
            }
          end

          grouped_products.sort! do |a, b|
            b[:quantity] <=> a[:quantity]
          end
          grouped_products = grouped_products[0..9]

          top_products_by_type = []
          grouped_products.group_by do |product|
            product[:category]
          end.each do |category, products|
            type_products = {
              name: category,
              products: products
            }
            top_products_by_type << type_products
          end

          # ProductType.all.each do |product_type|
          #   subgroup = product_sales.where(products: { product_type_id: product_type.id}).group_by(&:product).map do |key, val|
          #     {
          #       name: key.name,
          #       category: key.product_type.name,
          #       quantity: val.inject(0) { |sum, x| sum + x.quantity},
          #       sales_amount: 0
          #     }
          #   end

          #   subgroup.sort! do |a, b|
          #     b[:quantity] <=> a[:quantity]
          #   end
          #   subgroup = subgroup[0..9]
          #   type_products = {
          #     name: product_type.name,
          #     products: subgroup
          #   }
          #   top_products_by_type << type_products
          # end

          images = Image.joins(report: :store)
          .merge(Report.unassigned)
          .where("category_id = ? AND reports.created_at >= ? AND reports.created_at <= ?", 3, @start_date, @end_date)


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
            sales_by_zone: sales_by_zone,
            share_percentages: share_percentages,
            sales_by_company: sales_by_company,
            year: @year,
            month: @month,
            id: @sales_date,
            top_products: grouped_products,
            top_products_by_type: top_products_by_type,
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

          images = Image.joins(report: :store)
          .merge(Report.unassigned)
          .where("category_id = ? AND reports.created_at >= ? AND reports.created_at < ?", 3, sales_date, end_date)


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
