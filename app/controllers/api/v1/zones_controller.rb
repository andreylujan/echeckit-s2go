class Api::V1::ZonesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  
end
