
excel_classes = [ DailyProductSale, DailyHeadCount, DailySale, SaleGoal, StockBreak, StockBreakEvent, WeeklyBusinessSale ]
excel_classes.each do |model_class|
	file_name = "xlsx/#{model_class.name.underscore}.xlsx"
	f = File.open(file_name, 'w')
	f.write(model_class.to_xlsx.to_stream.read)
	f.close
end