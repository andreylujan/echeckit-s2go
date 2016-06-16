class Api::V1::ChecklistOptionResource < JSONAPI::Resource
	attributes :name, :icon

	has_one :detail
end
