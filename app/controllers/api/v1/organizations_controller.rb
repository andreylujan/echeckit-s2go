class Api::V1::OrganizationsController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
  
end
