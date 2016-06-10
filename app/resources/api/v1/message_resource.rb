class Api::V1::MessageResource < BaseResource


	attributes :read, :read_at, :title, :html, :resource_id,
		:message_action

	def message_action
		@model.message_action.as_json.except("created_at", "updated_at")
	end

	def self.records(options = {})
		context = options[:context]
		user = context[:current_user]
		user.messages
	end

end
