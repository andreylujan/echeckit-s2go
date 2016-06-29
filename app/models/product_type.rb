# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: product_types
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductType < ActiveRecord::Base

  has_many :products

  validates :name, presence: true, uniqueness: true

  include NameCreatable

end
