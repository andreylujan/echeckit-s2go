# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrganizationSerializer < ActiveModel::Serializer
  attributes :id, :name
end
