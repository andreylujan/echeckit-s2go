class Api::V1::OrganizationsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
  
end
