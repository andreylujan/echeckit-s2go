# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  region_id  :integer          not null
#

require 'test_helper'

class ZoneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
