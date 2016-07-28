# == Schema Information
#
# Table name: checklist_item_values
#
#  id         :integer          not null, primary key
#  report_id  :integer          not null
#  item_value :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ChecklistItemValue, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
