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

    belongs_to :zone
    belongs_to :dealer

    validates_presence_of :name
end
