# -*- encoding : utf-8 -*-
class SendMessageJob < ActiveJob::Base
	queue_as :default

	def perform(report_id, regenerate_uuid=false)
		
	end
end
