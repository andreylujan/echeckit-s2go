# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: checklist_item_values
#
#  id           :integer          not null, primary key
#  report_id    :integer          not null
#  item_value   :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  data_part_id :integer          not null
#  image_list   :json
#

require 'rails_helper'

RSpec.describe ChecklistItemValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
