class Api::V1::RolesController < Api::V1::JsonApiController
	before_action :doorkeeper_authorize!
end
