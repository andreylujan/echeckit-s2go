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

class Zone < ActiveRecord::Base
    belongs_to :region
    has_and_belongs_to_many :dealers
    has_many :stores
    has_and_belongs_to_many :promotions
end
