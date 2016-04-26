# == Schema Information
#
# Table name: categories
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ChecklistOptionSerializer < DataPartSerializer
	attributes :detail_id
end
