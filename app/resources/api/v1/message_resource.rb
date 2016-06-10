class Api::V1::MessageResource < BaseResource
	has_one :broadcast

	attributes :read, :read_at


	def self.records(options = {})
		context = options[:context]
		user = context[:current_user]
		user.messages
	end

end
