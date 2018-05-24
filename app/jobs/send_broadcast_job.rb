# -*- encoding : utf-8 -*-
class SendBroadcastJob < ActiveJob::Base
  queue_as :eretail_push

  def perform(broadcast_id)

    # unless Rails.env.production?
    #   return
    # end

    broadcast = Broadcast.find_by_id(broadcast_id)
    if broadcast.nil?
      return
    end
    Rails.logger.info "Recipients : #{broadcast.recipients}"

    recipients = broadcast.recipients.uniq

    Rails.logger.info "Filter recipients : #{recipients}"


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
        action_id: "2",
        resource_id: "#{broadcast.resource_id}",
        action_name: "#{broadcast.message_action_name}"
      },
      gcm_app_name: gcm_app_name,
      apns_app_name: apns_app_name
    }

    registration_ids = []
    device_tokens = []

    recipients.each do |recipient|
      devices = recipient.devices
      registration_ids = registration_ids + devices.where("registration_id is not null").map { |r| r.registration_id }
      device_tokens = device_tokens + devices.where("device_token is not null").map { |r| r.device_token }
    end

    registration_ids.uniq!
    device_tokens.uniq!

    if registration_ids.length > 0 or device_tokens.length > 0
      body = params.merge({
                            registration_ids: registration_ids,
                            device_tokens: device_tokens
      })
      response = conn.post do |req|
        req.url '/notifications'
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
      end
    end
  end
end
