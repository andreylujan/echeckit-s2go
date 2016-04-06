# == Schema Information
#
# Table name: roles
#
#  id              :integer          not null, primary key
#  organization_id :integer          not null
#  name            :text             not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
