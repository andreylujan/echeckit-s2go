# -*- encoding : utf-8 -*-
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

class Device < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :user
  before_create :destroy_repeated_devices
  after_create :destroy_old_devices
  # validates :device_token, uniqueness: true, allow_nil: true
  # validates :registration_id, uniqueness: true, allow_nil: true

  private

  def destroy_repeated_devices
    devices = Device.where(registration_id: self.registration_id)
    devices.destroy_all
  end

  def destroy_old_devices
    user = self.user
    devices = user.devices.where(name: self.name)
    .order("created_at ASC")
    devices_count = devices.count
    while devices_count > 8
      devices.first.destroy!
      devices = user.devices.where(name: self.name)
        .order("created_at ASC")
      devices_count = devices.count
    end
  end
end
