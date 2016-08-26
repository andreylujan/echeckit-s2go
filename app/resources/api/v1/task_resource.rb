# -*- encoding : utf-8 -*-
class Api::V1::TaskResource < JSONAPI::Resource
	has_many :dealers
	has_many :stores
	has_many :zones
	has_many :promoters, class_name: "User"
	attributes :title, :description, :task_start, :task_end, :all_promoters
end
