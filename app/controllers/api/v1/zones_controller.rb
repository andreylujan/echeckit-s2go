class Api::V1::ZonesController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
  
end
