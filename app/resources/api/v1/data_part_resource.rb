# -*- encoding : utf-8 -*-
class Api::V1::DataPartResource < JSONAPI::Resource
	attributes :name, :children

	has_many :childen
	has_one :detail

	def children
		@model.children
	end
	filters :type

end
