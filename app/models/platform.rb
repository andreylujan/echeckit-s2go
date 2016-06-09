# == Schema Information
#
# Table name: platforms
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Platform < ActiveRecord::Base
  has_and_belongs_to_many :products
end
