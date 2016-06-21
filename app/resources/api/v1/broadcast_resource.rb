# -*- encoding : utf-8 -*-
class Api::V1::BroadcastResource < BaseResource
	attributes :title, :html, :resource_id, :send_at, :sent,
		:send_to_all, :is_immediate, :created_at
		
	has_one :message_action
	has_many :recipients

	before_create :set_sender

	def set_sender(broadcast = @model, context = @context)
		user = context[:current_user]
    	broadcast.sender = user
	end

	def self.updatable_fields(context)
    super - [:sent]
  end

  def self.creatable_fields(context)
    super - [:sent]
  end
end
