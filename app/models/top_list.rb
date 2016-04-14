# == Schema Information
#
# Table name: top_lists
#
#  id              :integer          not null, primary key
#  organization_id :integer          not null
#  name            :text
#  icon            :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class TopList < ActiveRecord::Base
  belongs_to :organization
  has_many :top_list_items
end
