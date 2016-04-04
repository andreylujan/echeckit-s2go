# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  ordinal    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Region < ActiveRecord::Base
    has_many :zones
end
