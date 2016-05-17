class Api::V1::PlatformsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
 
end
