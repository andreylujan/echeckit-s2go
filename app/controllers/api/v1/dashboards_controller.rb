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

  def filtered_stock_breaks(start_date = @start_date, end_date = @end_date, order=true)
    stock_breaks = StockBreakEvent.joins(report: :store)
    .merge(Report.unassigned)
    .where("reports.created_at >= ? AND reports.created_at <= ?", start_date, end_date)

    if order
      stock_breaks = stock_breaks.order("reports.created_at DESC")
    end

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
      .includes(store: [:dealer, :zone])
      .order("month ASC, week_number ASC"),
      WeeklyBusinessSale.where("month >= ? AND month <= ?",
       DateTime.now.beginning_of_year, DateTime.now.end_of_year)
      .includes(store: [:dealer, :zone])
      .order("month ASC, week_number ASC"),
      SaleGoal.where("goal_date >= ? AND goal_date <= ?",
       DateTime.now.beginning_of_year - 1.year,
       DateTime.now.end_of_year)
      .includes(store: [:dealer, :zone])
      .order("goal_date ASC")
    ]
    excel_classes[0].to_xlsx package: package, name: "Ventas #{current_year - 1}"
    excel_classes[1].to_xlsx package: package, name: "Ventas #{current_year}"
    excel_classes[2].to_xlsx package: package, name: "Metas #{current_year - 1} - #{current_year}"

    render text: package.to_stream.read
  end

  def category
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
      sales_unit = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.unit_hardware_sales + x.unit_accessory_sales + x.unit_game_sales
        sales_accessory + x.unit_accessory_sales
      end


      goal_amount = goal[1].inject(0) do |sum, x|
        sum + x.monthly_goal
      end
      goal_unit = goal[1].inject(0) do |sum, x|
        sum + x.unit_monthly_goal
      end

      #goal[1].inject(0) do |sum, x|
      #  case x.goal_category.upcase
      #  when 'JUEGOS'
      #    Rails.logger.info "Juegos: #{x.unit_monthly_goal}"
      #    goal_games + x.unit_monthly_goal
      #  when 'ACCESORIOS'
      #    goal_accessory + x.unit_monthly_goal
      #  when 'CONSOLAS'
      #    goal_hardware  + x.unit_monthly_goal
      #    end
      #end

      sales_games = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.unit_game_sales
      end
      sales_hardware = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.unit_hardware_sales
      end
      sales_accessory = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.unit_accessory_sales
      end

      goal_hardware = goal[1].inject(0) do |sum, x|
        if x.goal_category.upcase == 'CONSOLAS'
          sum + + x.unit_monthly_goal
        end
      end
      goal_games = goal[1].inject(0) do |sum, x|
        if x.goal_category.upcase == 'ACCESORIOS'
          sum + x.unit_monthly_goal
        end
      end
      goal_accessory = goal[1].inject(0) do |sum, x|
        if x.goal_category.upcase == 'JUEGOS'
          sum + x.unit_monthly_goal
        end
      end

      {
        name: goal[0].name,
        goal_amount: goal_amount,
        goal_unit: goal_unit,
        sales_amount: sales_amount,
        sales_unit: sales_unit,
        goal_percentage: sales_amount.to_f/goal_amount.to_f,
        goal_percentage_unit: sales_amount.to_f/goal_amount.to_f,
        categories: [{name:'Consola', goal:goal_hardware,sale:sales_hardware, percentage:sales_hardware.to_f/goal_hardware.to_f},
          {name:'Juego', goal:goal_games,sale:sales_games, percentage:sales_games.to_f/goal_games.to_f},
          {name:'Accesorio', goal:goal_accessory,sale:sales_accessory, percentage:sales_accessory.to_f/goal_accessory.to_f}]
      }
    end

    render json: {
       data: {
         id: "#{@start_date}",
         type: "goal_dashboards",
         attributes: {
           monthly_sales_vs_goals: monthly_sales_vs_goals
         }
       }
     }
  end

  def categories
    category = []
    saleGoal = SaleGoal.select("distinct goal_category ").where("goal_category != ''")
    saleGoal.each do |sale|
      category << sale.goal_category
    end
    category
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
    Rails.logger.info "sales_by_dealer: #{sales_by_dealer}"
    cats = categories
    monthly_sales_vs_goals = goals_by_dealer.map do |goal|
      sales = sales_by_dealer.find(ifnone = nil) { |d| d[0].id == goal[0].id }
      sale = []
      cats.map do |cat|
        total = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
          s = 0
          if cat == x.category
            s = x.goals_sales['venta']
          end
          sum + s
        end
        sale << {name: cat, total: total}
      end
      Rails.logger.info "sale: #{sale}"

      goals = []
      cats.map do |cat|
        total = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
          v = 0
          if cat == x.category
            v = x.goals_sales['metas']
          end
          sum + v
        end
        goals << {name: cat, total:total}
      end
      categories = []
      cat = nil
      sale.map do |s|
        goals.map do |g|
          if s[:name] == g[:name]
            cat = {name: s[:name], goal: g[:total], sale: s[:total], percentage:s[:total].to_f/ g[:total].to_f}
          end
        end
        categories << cat
      end

      sales_unit = 0
      sale.map do |s|
        sales_unit = sales_unit + s[:total]
      end

      goal_unit = 0
      goals.map do |g|
        goal_unit = goal_unit + g[:total]
      end


      sales_amount = sales.nil? ? 0 : sales[1].inject(0) do |sum, x|
        sum + x.hardware_sales + x.accessory_sales + x.game_sales
      end

      goal_amount = goal[1].inject(0) do |sum, x|
        sum + x.monthly_goal
      end


      #Rails.logger.info "unit_monthly_goal: #{x.unit_monthly_goal}"
      {
        name: goal[0].name,
        goal: goal_amount,
        sales: sales_amount,
        goal_unit: goal_unit,
        sales_unit: sales_unit,
        goal_percentage: sales_amount.to_f/goal_amount.to_f,
        categories: categories
      }
    end

    newest_sales_week = WeeklyBusinessSale.order("month DESC, week_number DESC").limit(1).first
    current_week_of_year = newest_sales_week.week_number
    current_year = newest_sales_week.year

    last_week_sales = filtered_weekly_sales_by_week(current_year, current_week_of_year - 1)
    .includes(store: :dealer)
    .group_by(&:dealer_criteria)

    current_week_sales_data = filtered_weekly_sales_by_week(current_year, current_week_of_year)
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
    first_month_week = selected_date.beginning_of_month.cweek
    last_month_week = selected_date.end_of_month.cweek

    last_year_weekly_sales = filtered_weekly_sales_by_week_number(selected_date.year - 1, first_month_week, last_month_week).group_by(&:week_number)
    current_year_weekly_sales = filtered_weekly_sales_by_week_number(selected_date.year, first_month_week, last_month_week).group_by(&:week_number)

    iterations = last_month_week - first_month_week + 1
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

    found_data = false
    12.times do |i|
      if found_data or last_year_monthly_sales[i + 1].present? or current_year_monthly_sales[i + 1].present?
        found_data = true
        if not last_year_monthly_sales[i + 1].present?
          last_year_monthly_sales[i + 1] = []
        end
        if not current_year_monthly_sales[i + 1].present?
          current_year_monthly_sales[i + 1] = []
        end
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

  def filtered_weekly_sales_by_week(year, week_number)
    weekly_sales = WeeklyBusinessSale.joins(:store)
    .where("week_number = ? AND extract(year from month) = ?", week_number, year)

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

  def filtered_weekly_sales_by_week_number(year, start_week, end_week)

    weekly_sales = WeeklyBusinessSale.joins(:store)
    .where("week_number >= ? AND week_number <= ? AND extract(year from month) = ?", start_week, end_week,
      year)

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
    .where("month >= ? AND month <= ?", start_date.beginning_of_month, end_date.end_of_month)

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
      .includes(report: [{ store: [ :dealer, :zone, :instructor, :supervisor]}, :creator])
      .includes(product: [ :product_classification, :product_type ])
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
      top_stock_breaks = []

      filtered_stock_breaks.includes(report: { store: :dealer })
      .includes(product: [ :product_type, :product_classification ])
      .group_by(&:group_by_store_criteria).each do |store, group|
        if group.length > 0
          stock_break = group.max { |a, b| a.report.created_at <=> b.report.created_at }
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

      filtered_stock_breaks(@start_date, @end_date, false)
      .includes(report: { store: :dealer })
      .includes(:product)
      .group_by(&:group_by_product_criteria)
      .sort { |a, b| b[1].length <=> a[1].length }[0..2]
      .each do |product, group|
        subgroup_json = []

        group.group_by(&:group_by_dealer_criteria)
        .sort { |a, b| a[0].name <=> b[0].name }
        .each do |dealer, subgroup|
          subgroup_hash = {
            dealer_name: dealer.name,
            num_stock_breaks: subgroup.length
          }
          subgroup_json << subgroup_hash
        end
        group_json =
        {
          product_name: product.name,
          stock_breaks_by_dealer: subgroup_json
        }
        top_stock_breaks << group_json
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

      filtered_stocks = filtered_daily_stocks

      stocks_by_company = []
      share_percentages = []
      filtered_stocks = filtered_daily_stocks

      hardware_stocks = filtered_stocks.inject(0) { |sum, x| sum + x.hardware_sales }
      accessory_stocks = filtered_stocks.inject(0) { |sum, x| sum + x.accessory_sales }
      game_stocks = filtered_stocks.inject(0) { |sum, x| sum + x.game_sales }

      total_stocks = hardware_stocks + accessory_stocks + game_stocks

      Brand.all.each do |brand|
        brand_stocks = filtered_stocks.where(brand: brand)
        stocks_amount = brand_stocks.inject(0) { |sum, x| sum + x.hardware_sales } +
        brand_stocks.inject(0) { |sum, x| sum + x.accessory_sales } +
        brand_stocks.inject(0) { |sum, x| sum + x.game_sales }
        share_obj = {
          name: brand.name,
          stocks_amount: stocks_amount,
          share_percentage: total_stocks > 0 ? stocks_amount.to_f/total_stocks.to_f : 0
        }
        share_percentages << share_obj

        brand_hardware_stocks = brand_stocks.inject(0) { |sum, x| sum + x.hardware_sales }
        brand_accessory_stocks = brand_stocks.inject(0) { |sum, x| sum + x.accessory_sales }
        brand_game_stocks = brand_stocks.inject(0) { |sum, x| sum + x.game_sales }

        company_stocks = {
          name: brand.name,
          stocks_by_type: {
            hardware: brand_hardware_stocks,
            accessories: brand_accessory_stocks,
            games: brand_game_stocks,
            total: brand_hardware_stocks + brand_accessory_stocks + brand_game_stocks
          }
        }
        stocks_by_company << company_stocks

      end


      data = {
        id: @start_date,
        top_products: grouped_products,
        stock_breaks: stock_breaks,
        top_stock_breaks: top_stock_breaks,
        share_percentages: share_percentages,
        stocks_by_company: stocks_by_company
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
      .select("distinct on (date_trunc('month', reports.created_at), reports.store_id, daily_head_counts.brand_id) daily_head_counts.*")
      .joins(report: :store)
      .merge(Report.unassigned)
      .where("reports.created_at >= ? AND reports.created_at <= ?", start_date, end_date)
      .order("date_trunc('month', reports.created_at), reports.store_id, daily_head_counts.brand_id, reports.created_at DESC")

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

    def filtered_checkins(start_date = @start_date, end_date = @end_date, only_exits = true)

      if only_exits
        checkins = Checkin.joins(:store)
        .where("checkins.arrival_time >= ? AND checkins.arrival_time < ? AND checkins.exit_time is not null",
         start_date, end_date)
      else
        checkins = Checkin.joins(:store)
        .where("checkins.arrival_time >= ? AND checkins.arrival_time < ?",
         start_date, end_date)
      end

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

    def filtered_daily_stocks(start_date = @start_date, end_date = @end_date)
     daily_stocks = DailyStock
     .select('DISTINCT ON(reports.store_id, brand_id, extract(month from reports.created_at)) daily_stocks.*')
     .joins(report: :store)
     .merge(Report.unassigned)
     .where("reports.created_at >= ? AND reports.created_at <= ?", start_date, end_date)
     .order('reports.store_id, brand_id, extract(month from reports.created_at), reports.created_at DESC')

     if params[:store_id].present?
      daily_stocks = daily_stocks.where(reports: { store_id: params[:store_id].to_i })
    end

    if params[:dealer_id].present?
      daily_stocks = daily_stocks.where(stores: { dealer_id: params[:dealer_id].to_i })
    end

    if params[:instructor_id].present?
      daily_stocks = daily_stocks.where(stores: { instructor_id: params[:instructor_id].to_i })
    end

    if params[:supervisor_id].present?
      daily_stocks = daily_stocks.where(stores: { supervisor_id: params[:supervisor_id].to_i })
    end

    if params[:zone_id].present?
      daily_stocks = daily_stocks.where(stores: { zone_id: params[:zone_id].to_i })
    end
    daily_stocks
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

  def group_by_day_last_month(collection, actual_collection, criteria, &block)
      groups_actual = actual_collection.group_by(&criteria).map(&block).sort
      groups_last = collection.group_by(&criteria).map(&block).sort
      current_index = 0
      filled_in_groups = []
      groups = []

      for i in 0..groups_actual.length-1
        for j in 0..groups_last.length-1
          if groups_actual[i][0].mday === groups_last[j][0].mday
            groups << groups_actual[i]
            groups[current_index][2] = groups_last[j][1]
            current_index += 1
          end
        end
      end
      current_index = 0
      current_index_aux = -1

      @days_in_month.times do |i|
        current_index_aux += 1
        if groups[current_index] && groups[current_index][0].day == (i + 1)
          filled_in_groups << groups[current_index]
          current_index += 1
        else
          date = DateTime.new(@year.to_i, @month.to_i, (i + 1)).to_date
          if @current_date > date
            if groups[current_index_aux] && groups[current_index_aux][0].day == (i + 1)
              new_day = [ date, 0, groups[current_index_aux][2]] #cambiar esto para que funcione bien
            else
              new_day = [ date, 0, 0]
            end
        else
          new_day = [ date, -1 , 0]
        end
        filled_in_groups << new_day #agregale new day
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


  def group_checklist_by_day_last_month(collection, actual_collection, criteria, &block)
    groups_actual = actual_collection.group_by(&criteria).map(&block).sort
    groups_last = collection.group_by(&criteria).map(&block).sort

    current_index = 0
    filled_in_groups = []
    groups = []
    p "inicio"
    p groups_actual
    #p groups_last[0][0].mday
    #p groups
    p "fin"
    for i in 0..groups_actual.length-1
      for j in 0..groups_last.length-1
        if groups_actual[i][0].mday === groups_last[j][0].mday
          groups << groups_actual[i]
          groups[current_index][2] = groups_last[j][1]
          current_index += 1
        end
      end
    end

    if groups == []
      for i in 0..groups_actual.length-1
        groups << groups_actual[i]
        groups[i][3] = 0
      end
    end

    current_index = 0
    current_index_aux = -1

    #p "inicio"
    #p groups_actual
    #p groups_last
    #p groups
    #p "fin"

    @days_in_month.times do |i|
      if groups[current_index] && groups[current_index][0].day == (i + 1)
        filled_in_groups << groups[current_index]
      else
        date = DateTime.new(@year.to_i, @month.to_i, (i + 1)).to_date
        if @current_date > date
          if groups[current_index_aux] && groups[current_index_aux][0].day == (i + 1)
              new_day = [ date, 0, 0, groups[current_index_aux][2]] #cambiar esto para que funcione bien
            else
              new_day = [ date, 0, 0, 0]
            end
        else
          new_day = [ date, -1, -1, -1 ]
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
      .includes(:creator, :report_type, :checklist_item_values)
      .where(finished: true, is_task: false)
      .order("created_at DESC"),
      Checkin.includes(store: [ :zone, :dealer ])
      .includes(:user)
      .order('arrival_time DESC'),
      DailyHeadCount
      .includes(report: [{ store: [ :zone, :dealer, :instructor, :supervisor ]}, :creator])
      .includes(:brand)
      .order("reports.created_at DESC")]
      excel_classes.each do |model_class|
        model_class.to_xlsx(package: package)
      end
      render text: package.to_stream.read
    end

  def get_accumulated_last_month(shortened_groups, accumulated = true)
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

  def promoter_activity

    if params[:format] == "xlsx"
      promoter_activity_xlsx
      return
    end

    @days_in_month = @start_date.end_of_month.day
    @current_date = DateTime.now

    # reports = filtered_reports
    # reports_last_month = filtered_reports(@current_date.beginning_of_month.last_month, @current_date.at_end_of_month.last_month)
    # num_reports_today = filtered_reports(@current_date.beginning_of_day, @current_date).count
    # num_reports_yesterday = filtered_reports(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day).count
    # grouped = group_by_day_last_month(reports_last_month, reports, :group_by_date_criteria) {|k,v,c| [k, v.length, c]}
    # reports_by_day = grouped[:by_day]
    # accumulated_reports = get_accumulated_last_month(grouped[:groups], false)

    reports = filtered_reports
    num_reports_today = filtered_reports(@current_date.beginning_of_day, @current_date).count
    num_reports_yesterday = filtered_reports(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day).count
    grouped = group_by_day(reports, :group_by_date_criteria) {|k,v| [k, v.length]}
    reports_by_day = grouped[:by_day]
    accumulated_reports = get_accumulated(grouped[:groups], false)

    reports_last = filtered_reports(@start_date - 1.month, @end_date - 1.month)
    grouped_last = group_by_day(reports_last, :group_by_date_criteria) {|k,v| [k, v.length]}
    reports_by_day_last = grouped_last[:by_day]
    accumulated_reports_last = get_accumulated(grouped_last[:groups], false)

    accumulated_reports.each_with_index do |data, idx|
      if idx < accumulated_reports_last.length
        data << accumulated_reports_last[idx][1]
      end
    end
    checkins = filtered_checkins
    checkins_last_month = filtered_checkins(@current_date.beginning_of_month.last_month, @current_date.at_end_of_month.last_month, true)
    checkins_without_exits = filtered_checkins(@start_date, @end_date, false)

    grouped_checkins_last_month = group_by_day_last_month(checkins_last_month, checkins, :group_by_date_criteria) {|k,v,c| [k, v.length,c]}
    grouped_checkins = group_by_day(checkins, :group_by_date_criteria) {|k,v| [k, v.length]}
    grouped_checkins_without_exits = group_by_day(checkins_without_exits, :group_by_date_criteria) { |k,v| [k, v.length]}

    num_checkins_today = filtered_checkins(@current_date.beginning_of_day, @current_date).count
    num_checkins_yesterday = filtered_checkins(@current_date.beginning_of_day - 1.day, @current_date.beginning_of_day).count

    checkins_by_day = grouped_checkins[:by_day]
    checkins_without_exits_by_day = grouped_checkins_without_exits[:by_day]
    checkins_by_day.each_with_index do |checkin, index|
      checkin[:amount_arrivals] = checkins_without_exits_by_day[index][:amount]
    end

    accumulated_checkins = get_accumulated_last_month(grouped_checkins_last_month[:groups], false)


    grouped_hours = group_by_day(checkins, :group_by_date_criteria) do |k, v|


      [
        k, ((v.inject(0) do |sum, x|
         sum + (x.exit_time-x.arrival_time)
       end)/1.hour).ceil
      ]
    end

    grouped_hours_last_month = group_by_day_last_month(checkins_last_month, checkins, :group_by_date_criteria) do |k, v, c|


      [
        k, ((v.inject(0) do |sum, x|
         sum + (x.exit_time-x.arrival_time)
       end)/1.hour).ceil
      ]
    end
    hours_by_day = grouped_hours[:by_day]
    accumulated_hours = get_accumulated_last_month(grouped_hours_last_month[:groups], false)
    num_hours_today = filtered_checkins(@current_date.beginning_of_day, @current_date).inject(0) do |sum, x|
      sum + (x.exit_time-x.arrival_time)
    end
    num_hours_today = (num_hours_today/1.hour).ceil
    num_hours_yesterday = filtered_checkins(@current_date.beginning_of_day - 1.day,
      @current_date.beginning_of_day).inject(0) do |sum, x|
      sum + (x.exit_time-x.arrival_time)
    end
    num_hours_yesterday = (num_hours_yesterday/1.hour).ceil

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
          num_part_time: brand_counts.inject(0) {|sum,x| sum + x.num_part_time },
          num_apoyo_time: brand_counts.inject(0) {|sum,x| sum + x.num_apoyo_time }
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
          num_part_time: 0,
          num_apoyo_time: 0
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
            num_part_time: brand_counts.inject(0) {|sum,x| sum + x.num_part_time },
            num_apoyo_time: brand_counts.inject(0) {|sum,x| sum + x.num_apoyo_time }
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
              num_part_time: 0,
              num_apoyo_time: 0
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
    communicated_promotions_last_month = filtered_checklist_values(@current_date.beginning_of_day.last_month, @current_date.end_of_month.last_month, 145)
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

    grouped_promotions_last_month = group_checklist_by_day_last_month(communicated_promotions_last_month.includes(:report), communicated_promotions_month.includes(:report), :group_by_date_criteria) do |k, v|
      [
        k,
        v.inject(0) { |sum, x | x.item_value ? sum + 1 : sum },
        v.length
      ]
    end

    promotions_by_day = grouped_promotions[:by_day]
    accumulated_promotions = get_accumulated_last_month(grouped_promotions_last_month[:groups], false)

    images = Image.joins(report: :store)
    .includes(report: { store: [ :dealer, :zone ]})
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
    .map do |image|
      {
        url: image.image_url,
        zone_name: image.zone_name,
        dealer_name: image.dealer_name,
        store_name: image.store_name,
        creator_name: image.creator_name,
        creator_email: image.creator_email,
        created_at: image.created_at,
        comment: image.comment
      }
    end


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
      accumulated_promotions: accumulated_promotions,
      best_practices: best_practices
    }

    promoter_activity = PromoterActivity.new data

    render json: JSONAPI::ResourceSerializer.new(Api::V1::PromoterActivityResource)
    .serialize_to_hash(Api::V1::PromoterActivityResource.new(promoter_activity, nil))

  end

  def sales_xlsx
    package = Axlsx::Package.new
    @start_date = DateTime.new(2000, 1, 1)
    @end_date = DateTime.new(2025, 1, 1)
    excel_classes = [ filtered_product_sales
      .includes(report: [{ store: [ :dealer, :zone, :supervisor, :instructor ]}, :creator])
      .includes(product: :product_classification)
      .order("reports.created_at DESC"),
      filtered_daily_sales
      .includes(report: [{store: [ :dealer, :zone, :supervisor, :instructor ]}, :creator])
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
          .includes(report: { store: [ :dealer, :zone ]})
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
          .map do |image|
            {
              url: image.image_url,
              zone_name: image.zone_name,
              dealer_name: image.dealer_name,
              store_name: image.store_name,
              creator_name: image.creator_name,
              creator_email: image.creator_email,
              created_at: image.created_at,
              comment: image.comment
            }
          end


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
          .includes(report: { store: [ :dealer, :zone ]})
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
          .map do |image|
            {
              url: image.image_url,
              zone_name: image.zone_name,
              dealer_name: image.dealer_name,
              store_name: image.store_name,
              creator_name: image.creator_name,
              creator_email: image.creator_email,
              created_at: image.created_at
            }
          end

          data = {
            id: sales_date,
            image_urls: image_urls
          }

          practices = BestPractices.new(data)

          render json: JSONAPI::ResourceSerializer.new(Api::V1::BestPracticesResource)
          .serialize_to_hash(Api::V1::BestPracticesResource.new(practices, nil))

        end

      end
