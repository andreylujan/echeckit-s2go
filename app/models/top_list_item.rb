# == Schema Information
#
# Table name: top_list_items
#
#  id          :integer          not null, primary key
#  top_list_id :integer
#  name        :text             not null
#  images      :text             default([]), not null, is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TopListItem < ActiveRecord::Base
  belongs_to :top_list
  has_and_belongs_to_many :platforms
end
