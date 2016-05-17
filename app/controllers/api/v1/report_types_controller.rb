class Api::V1::ReportTypesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  
end
