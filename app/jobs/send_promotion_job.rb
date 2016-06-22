# -*- encoding : utf-8 -*-
class SendPromotionJob < ActiveJob::Base
	queue_as :default

	def perform(promotion_id)
		promotion = Promotion.find(promotion_id)
		users = promotion.users
		
		if users.length == 0
			users = User.all
		end		

		apns_app_name = ENV["APNS_APP_NAME"]
    	gcm_app_name = ENV["GCM_APP_NAME"]
    	
		conn = Faraday.new(:url => ENV["PUSH_ENGINE_HOST"])
		params = {
			alert: "eRetail: Promoción creada",
			data: {
				message: "#{promotion.title}",
				title: "eRetail: Promoción creada",
				action_id: "0",
				resource_id: promotion.id.to_s
				},
				gcm_app_name: gcm_app_name,
				apns_app_name: apns_app_name
			}

			users.each do |user|
				device = user.devices.last
				if not device.nil?
					if device.name == "android"
						body = params.merge({ registration_id: device.registration_id })
					else
						body = params.merge({ device_token: device.device_token })
					end
					response = conn.post do |req|
						req.url '/notifications'
						req.headers['Content-Type'] = 'application/json'
						req.body = body.to_json
					end
				end
			end
		end
	end
