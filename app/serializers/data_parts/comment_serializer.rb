# == Schema Information
#
# Table name: data_parts
#
#  id            :integer          not null, primary key
#  subsection_id :integer
#  type          :text             not null
#  name          :text             not null
#  icon          :text
#  required      :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ancestry      :string
#

class CommentSerializer < DataPartSerializer
	attributes :max_length, :multiline, :field_type

	def multiline
		object.data["multiline"] || false
	end

	def field_type
		object.data["type"] || "text"
	end
end
