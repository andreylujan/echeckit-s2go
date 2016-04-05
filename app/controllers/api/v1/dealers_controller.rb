class Api::V1::DealersController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
  
end
