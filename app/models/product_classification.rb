# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: product_classifications
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductClassification < ActiveRecord::Base
  has_many :products
  has_many :stock_breaks
end
