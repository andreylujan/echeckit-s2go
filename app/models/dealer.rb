# == Schema Information
#
# Table name: dealers
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  contact      :text
#  phone_number :text
#  address      :text
#

class Dealer < ActiveRecord::Base
    has_and_belongs_to_many :zones
    has_and_belongs_to_many :stores
    has_and_belongs_to_many :promotions
    validates_presence_of :name
    validates_uniqueness_of :name

end
