class Api::V1::RolesController < ApplicationController
	before_action :doorkeeper_authorize!
  	include JSONAPI::ActsAsResourceController
end
