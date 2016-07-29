# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: sale_goals
#
#  id                  :integer          not null, primary key
#  store_id            :integer          not null
#  monthly_goal        :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  goal_date           :datetime         not null
#  sale_goal_upload_id :integer
#

require 'rails_helper'

RSpec.describe SaleGoal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
