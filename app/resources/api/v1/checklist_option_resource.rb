# -*- encoding : utf-8 -*-
class Api::V1::ChecklistOptionResource < BaseResource
	attributes :name, :icon, :is_binary

	has_one :detail

	def is_binary
		if @model.data["is_binary"]
			@model.data["is_binary"]
		else
			false
		end
	end
end
