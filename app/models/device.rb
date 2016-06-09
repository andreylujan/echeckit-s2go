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
end
