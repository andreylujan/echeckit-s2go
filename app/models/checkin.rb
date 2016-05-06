# == Schema Information
#
# Table name: checkins
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  zone_id       :integer          not null
#  dealer_id     :integer          not null
#  store_id      :integer          not null
#  arrival_time  :datetime         not null
#  exit_time     :datetime
#  subsection_id :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :zone
  belongs_to :dealer
  belongs_to :store
  belongs_to :subsection
end
