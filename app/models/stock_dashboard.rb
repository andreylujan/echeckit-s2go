# -*- encoding : utf-8 -*-
class StockDashboard
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :stock_breaks
	attr_accessor :top_products
end
