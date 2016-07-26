# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: checkins
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  arrival_time   :datetime         not null
#  exit_time      :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  data           :json             not null
#  arrival_lonlat :geometry({:srid= point, 0
#  exit_lonlat    :geometry({:srid= point, 0
#  store_id       :integer
#

require 'rails_helper'

RSpec.describe Checkin, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
