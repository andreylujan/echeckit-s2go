class SalesReport
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :sales_by_zone
	attr_accessor :share_percentages
	attr_accessor :sales_by_company
	attr_accessor :year
	attr_accessor :month
end