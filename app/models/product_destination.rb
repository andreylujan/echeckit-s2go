# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: product_destinations
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductDestination < ActiveRecord::Base
  has_many :products
end
