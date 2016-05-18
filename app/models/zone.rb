# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Zone < ActiveRecord::Base
    has_and_belongs_to_many :dealers
    has_and_belongs_to_many :stores
    has_and_belongs_to_many :promotions

    validates_presence_of :name
    validates_uniqueness_of :name
end
