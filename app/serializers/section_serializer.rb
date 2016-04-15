# == Schema Information
#
# Table name: sections
#
#  id              :integer          not null, primary key
#  position        :integer
#  name            :text
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_type_id :integer          not null
#

class SectionSerializer < ActiveModel::Serializer
	attributes :id, :position, :name, :section_type_id
	has_many :subsections
end
