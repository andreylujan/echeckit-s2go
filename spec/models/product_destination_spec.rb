# == Schema Information
#
# Table name: product_destinations
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe ProductDestination, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
