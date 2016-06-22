# -*- encoding : utf-8 -*-
class SendBroadcastJob < ActiveJob::Base
	queue_as :default

	def perform(broadcast_id)
		broadcast = Broadcast.find(broadcast_id)
		recipients = broadcast.recipients
		
		broadcast.update_attribute :sent, true

		if recipients.length == 0
			recipients = User.all
		end		

		apns_app_name = ENV["APNS_APP_NAME"]
    	gcm_app_name = ENV["GCM_APP_NAME"]
    	
		conn = Faraday.new(:url => ENV["PUSH_ENGINE_HOST"])
		params = {
			alert: "#{broadcast.title}",
			data: {
				message: "eRetail: Mensaje recibido",
				title: "#{broadcast.title}",
				action_id: "#{broadcast.message_action_id}",
				resource_id: "#{broadcast.resource_id}",
				action_name: "#{broadcast.message_action_name}"
				},
				gcm_app_name: gcm_app_name,
				apns_app_name: apns_app_name
			}

			recipients.each do |recipient|
				device = recipient.devices.last
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
