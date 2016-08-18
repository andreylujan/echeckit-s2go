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
excel_classes = [ StockBreak, StockBreakEvent ]
excel_classes.each do |model_class|
  model_class.to_xlsx(package: package)
end

file_name = "xlsx/quiebres_stock.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close

package = Axlsx::Package.new
excel_classes = [ DailyHeadCount ]
excel_classes.each do |model_class|
  model_class.to_xlsx(package: package)
end

file_name = "xlsx/actividad_promotores.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close

package = Axlsx::Package.new
excel_classes = [ SaleGoal, WeeklyBusinessSale ]
excel_classes.each do |model_class|
  model_class.to_xlsx(package: package)
end

file_name = "xlsx/metas_cumplimiento.xlsx"
f = File.open(file_name, 'w')
f.write(package.to_stream.read)
f.close
