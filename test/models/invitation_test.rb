# == Schema Information
#
# Table name: invitations
#
#  id                 :integer          not null, primary key
#  role_id            :integer          not null
#  confirmation_token :text             not null
#  email              :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
