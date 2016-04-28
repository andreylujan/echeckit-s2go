# == Schema Information
#
# Table name: data_parts
#
#  id              :integer          not null, primary key
#  subsection_id   :integer
#  type            :text             not null
#  name            :text             not null
#  icon            :text
#  required        :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ancestry        :string
#  max_images      :integer
#  max_length      :integer
#  data            :json             not null
#  position        :integer          default(0), not null
#  detail_id       :integer
#  organization_id :integer
#

class DataPart < ActiveRecord::Base
  belongs_to :subsection  
  acts_as_list scope: :subsection
  # belongs_to :data_part
  # has_many :children, class_name: :DataPart
  # belongs_to :parent, class_name: :DataPart, foreign_key: :data_part_id
  has_ancestry
  belongs_to :organization
end
