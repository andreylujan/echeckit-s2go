# -*- encoding : utf-8 -*-
class SendPromotionJob < ActiveJob::Base
  queue_as :eretail_promotion

  def perform(promotion_id)
    promotion = Promotion.find_by_id(promotion_id)
    if promotion.nil?
      return
    end
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

      devices = user.devices
      registration_ids = devices.where("registration_id is not null").map { |r| r.registration_id }
      device_tokens = devices.where("device_token is not null").map { |r| r.device_token }

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
