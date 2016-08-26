# -*- encoding : utf-8 -*-
class Api::V1::TaskResource < JSONAPI::Resource
	has_one :store
	has_many :assigned_users, class_name: "User"
	attributes :title, :description, :task_start, :task_end
end
