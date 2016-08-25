# -*- encoding : utf-8 -*-
package = Axlsx::Package.new
excel_classes = [ DailyProductSale.joins(:report).order("reports.created_at DESC"),
	 DailySale.joins(:report).order("reports.created_at DESC") ]
excel_classes.each do |model_class|
  model_class.to_xlsx(package: package)
end

file_name = "xlsx/ventas.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close

package = Axlsx::Package.new
excel_classes = [ StockBreakEvent.joins(:report).order("reports.created_at DESC"), StockBreak ]
excel_classes.each do |model_class|
  model_class.to_xlsx(package: package)
end

file_name = "xlsx/quiebres_stock.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close

package = Axlsx::Package.new
excel_classes = [ Report.order("updated_at DESC"), 
	Checkin.order('arrival_time DESC'),
	DailyHeadCount.order("count_date DESC") ]
excel_classes.each do |model_class|
  model_class.to_xlsx(package: package)
end

file_name = "xlsx/actividad_promotores.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close

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

file_name = "xlsx/metas_cumplimiento.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close
