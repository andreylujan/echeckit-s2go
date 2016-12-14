# -*- encoding : utf-8 -*-
class StockDashboard
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :stock_breaks
	attr_accessor :top_products
	attr_accessor :top_stock_breaks
	attr_accessor :share_percentages
	attr_accessor :stocks_by_company
end
