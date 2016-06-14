class Api::V1::MessageActionsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
	
end
