# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Brand < ActiveRecord::Base
	has_many :daily_head_counts
end
