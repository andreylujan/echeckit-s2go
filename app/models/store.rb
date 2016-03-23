# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  dealer_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Store < ApplicationRecord
  belongs_to :dealer
end
