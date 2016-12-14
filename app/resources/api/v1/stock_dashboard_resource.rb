# -*- encoding : utf-8 -*-
class Api::V1::StockDashboardResource < JSONAPI::Resource
	attributes :stock_breaks, :top_products, :top_stock_breaks,
		:share_percentages, :stocks_by_company
end
