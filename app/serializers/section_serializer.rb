# -*- encoding : utf-8 -*-
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
	attributes :id, :position, :name, :subsections, :section_type

	def section_type
		{
			id: object.section_type.id,
			name: object.section_type.name
		}
	end

	def subsections
		sub = []
		object.subsections.each do |s|
			sub << SubsectionSerializer.new(s).as_json
		end
		sub
	end
end
