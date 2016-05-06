# == Schema Information
#
# Table name: stores
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  dealer_id    :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  zone_id      :integer          not null
#  contact      :text
#  phone_number :text
#  address      :text
#

class Store < ActiveRecord::Base
    belongs_to :dealer
    belongs_to :zone
    has_many :checkins
end
