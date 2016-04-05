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

class DealerSerializer < ActiveModel::Serializer

end
