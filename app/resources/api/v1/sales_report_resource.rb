class Api::V1::SalesReportResource < JSONAPI::Resource
	attributes :sales_by_company, :year, :month
end
