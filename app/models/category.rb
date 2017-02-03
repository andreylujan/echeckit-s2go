# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: categories
#
#  id              		:integer          not null, primary key
#  name            		:text             not null
#  secundary_category 	:integer          not null
#  created_at      		:datetime         not null
#  updated_at      		:datetime         not null
#

class Category < ActiveRecord::Base
  belongs_to :secundary_category
  has_many :images
end
