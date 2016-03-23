# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Zone < ApplicationRecord
	has_many :dealers
end
