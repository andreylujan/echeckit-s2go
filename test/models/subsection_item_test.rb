# == Schema Information
#
# Table name: subsection_items
#
#  id                      :integer          not null, primary key
#  subsection_item_type_id :integer          not null
#  subsection_id           :integer          not null
#  has_details             :boolean          not null
#  name                    :text             not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

require 'test_helper'

class SubsectionItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
