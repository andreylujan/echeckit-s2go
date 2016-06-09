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

require 'rails_helper'

RSpec.describe Device, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
