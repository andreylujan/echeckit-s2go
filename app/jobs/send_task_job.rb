# -*- encoding : utf-8 -*-
class SendTaskJob < ActiveJob::Base
  queue_as :eretail_push

  def perform(report_id)

    # unless Rails.env.production?
    #   return
    # end

    report = Report.find_by_id(report_id)
    if report.nil?
      return
    end
    user = report.assigned_user

    if user.nil?
      return
    end

    apns_app_name = ENV["APNS_APP_NAME"]
    gcm_app_name = ENV["GCM_APP_NAME"]

    conn = Faraday.new(:url => ENV["PUSH_ENGINE_HOST"])
    params = {
      alert: "#{report.report_type.name} asignado",
      data: {
        message: "Se le ha asignado una tarea de tipo #{report.report_type.name}",
        title: "#{report.report_type.name} asignado",
        action_id: "1",
        resource_id: report.id.to_s
      },
      gcm_app_name: gcm_app_name,
      apns_app_name: apns_app_name
    }

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
