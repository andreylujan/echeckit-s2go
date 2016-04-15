# == Schema Information
#
# Table name: subsections
#
#  id         :integer          not null, primary key
#  section_id :integer
#  name       :text             not null
#  icon       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubsectionSerializer < ActiveModel::Serializer
	attributes :id, :name, :icon, :data_parts

	def data_parts
		parts = []
		object.data_parts.each do |part|
			parts << part.subtree.arrange_serializable { |parent, children| DataPartSerializer.new(parent, children: children).as_json }
		end
		parts
	end
end
