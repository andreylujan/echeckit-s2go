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
    has_many :users, through: :roles
    has_many :roles
    has_many :sections
    has_many :categories
    has_many :platforms
    has_many :top_lists
    has_many :report_types
end
