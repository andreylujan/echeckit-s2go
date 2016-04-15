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

class TopListSerializer < ActiveModel::Serializer
	attributes :id, :name
	has_many :top_list_items

end
