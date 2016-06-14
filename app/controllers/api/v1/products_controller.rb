# -*- encoding : utf-8 -*-
class Api::V1::ProductsController < Api::V1::JsonApiController

	before_action :doorkeeper_authorize!

	on_server_error :first_callback

	def self.first_callback(error)
      #env["airbrake.error_id"] = notify_airbrake(error)
    end
	
end
