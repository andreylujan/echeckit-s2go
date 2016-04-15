class Api::V1::PlatformsController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
  
  def index
  	platforms = current_user.organization.platforms
  	render json: platforms
  end
end
