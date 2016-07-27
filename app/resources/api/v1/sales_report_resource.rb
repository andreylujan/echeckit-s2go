class Api::V1::SalesReportResource < JSONAPI::Resource
	attributes :sales_by_zone, :share_percentages, :sales_by_company, :year, :month, :top_products
end
