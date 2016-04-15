# == Schema Information
#
# Table name: top_list_items
#
#  id          :integer          not null, primary key
#  top_list_id :integer
#  name        :text             not null
#  images      :text             default([]), not null, is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TopListItemSerializer < ActiveModel::Serializer
	attributes :id, :name, :images, :platform_ids
end
