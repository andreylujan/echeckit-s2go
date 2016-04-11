# == Schema Information
#
# Table name: sections
#
#  id              :integer          not null, primary key
#  position        :integer
#  title           :text
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_type_id :integer          not null
#

require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
