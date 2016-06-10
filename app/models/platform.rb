# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: platforms
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Platform < ActiveRecord::Base
  has_many :products, dependent: :nullify
end
