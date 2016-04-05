# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  region_id  :integer          not null
#

class ZoneSerializer < ActiveModel::Serializer
    attributes :name
    belongs_to :region
    has_many :dealers
end
