class Api::V1::MessagesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!
end
