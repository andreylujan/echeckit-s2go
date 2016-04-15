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

class TopListItemSerializer < ActiveModel::Serializer
	attributes :id, :name, :images, :platform_ids
end
