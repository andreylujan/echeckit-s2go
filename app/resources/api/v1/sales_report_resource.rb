# -*- encoding : utf-8 -*-
class Api::V1::SalesReportResource < JSONAPI::Resource
	attributes :sales_by_zone, :share_percentages, :sales_by_company, :year, :month, :top_products,
		:top_products_by_type
end
