# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: inbox_actions
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  name            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  resource_id     :integer
#

require 'rails_helper'

RSpec.describe InboxAction, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
