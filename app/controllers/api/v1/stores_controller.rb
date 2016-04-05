class Api::V1::StoresController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
  
end
