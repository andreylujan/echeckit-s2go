# == Schema Information
#
# Table name: platforms
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Platform < ActiveRecord::Base
  belongs_to :organization
  has_and_belongs_to_many :top_list_items
end
