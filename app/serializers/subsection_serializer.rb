# == Schema Information
#
# Table name: subsections
#
#  id         :integer          not null, primary key
#  section_id :integer
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubsectionSerializer < ActiveModel::Serializer
	attributes :id, :name, :data_parts

	def data_parts
		parts = []
		object.data_parts.each do |part|
			
			arr = part.subtree.arrange_serializable do |parent, children|
				serializer = Object.const_get "#{parent.type}Serializer"
				serializer.new(parent, children: children).as_json
			end
			parts << arr[0]
		end
		parts
	end
end
