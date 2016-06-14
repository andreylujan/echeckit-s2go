class Api::V1::BroadcastsController < Api::V1::JsonApiController
	before_action :doorkeeper_authorize!
end
