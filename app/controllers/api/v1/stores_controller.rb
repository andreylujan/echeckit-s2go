class Api::V1::StoresController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  
end
