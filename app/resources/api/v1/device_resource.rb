# == Schema Information
#
# Table name: devices
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  device_token    :text
#  registration_id :text
#  uuid            :text
#  architecture    :text
#  address         :text
#  locale          :text
#  manufacturer    :text
#  model           :text
#  name            :text
#  os_name         :text
#  processor_count :integer
#  version         :text
#  os_type         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Api::V1::DeviceResource < JSONAPI::Resource

	attributes :device_token, :registration_id, :uuid, :architecture, :address,
		:locale, :manufacturer, :model, :name, :os_name, :processor_count, :version,
		:os_type

	before_create :set_creator

	def set_creator(device = @model, context = @context)
		user = context[:current_user]
    	device.user = user
	end

end
