class Api::V1::ProductsController < Api::V1::JsonApiController

	before_action :doorkeeper_authorize!

	
end
