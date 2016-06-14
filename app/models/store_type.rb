# == Schema Information
#
# Table name: store_types
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StoreType < ActiveRecord::Base

	has_many :stores
	
end
