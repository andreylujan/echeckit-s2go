# == Schema Information
#
# Table name: stores
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  contact      :text
#  phone_number :text
#  address      :text
#

class Store < ActiveRecord::Base
    has_and_belongs_to_many :dealers
    has_and_belongs_to_many :zones
    has_many :checkins
end
