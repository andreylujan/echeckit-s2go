# == Schema Information
#
# Table name: platforms
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class PlatformSerializer < ActiveModel::Serializer
  attributes :id, :name
end
