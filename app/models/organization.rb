# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Organization < ActiveRecord::Base
    has_many :users
    has_many :roles
end
