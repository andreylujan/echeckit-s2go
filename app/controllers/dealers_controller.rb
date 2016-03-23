# == Schema Information
#
# Table name: dealers
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  zone_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DealersController < ApplicationController
end
