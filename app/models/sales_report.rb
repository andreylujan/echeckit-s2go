# -*- encoding : utf-8 -*-
class SalesReport
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :sales_by_zone
	attr_accessor :share_percentages
	attr_accessor :sales_by_company
	attr_accessor :year
	attr_accessor :month
	attr_accessor :top_products
	attr_accessor :top_products_by_type
	attr_accessor :best_practices
end
