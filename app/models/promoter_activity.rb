class PromoterActivity
	include ActiveModel::Model
	attr_accessor :id
	attr_accessor :reports_by_day
	attr_accessor :accumulated
	attr_accessor :year
	attr_accessor :month
end