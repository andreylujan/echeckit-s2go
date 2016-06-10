class Api::V1::BroadcastResource < BaseResource
	attributes :title, :html, :resource_id
	has_one :message_action
end
