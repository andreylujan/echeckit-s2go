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

class StoreSerializer < ActiveModel::Serializer

end
