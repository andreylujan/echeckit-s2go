class Api::V1::TopListsController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

end
