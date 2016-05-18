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
#  zone_id      :integer
#  dealer_id    :integer
#

class Store < ActiveRecord::Base
    has_and_belongs_to_many :dealers
    has_and_belongs_to_many :zones

    validates_uniqueness_of :name
    validates_presence_of :name
end
