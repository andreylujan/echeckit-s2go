# == Schema Information
#
# Table name: data_parts
#
#  id            :integer          not null, primary key
#  subsection_id :integer
#  type          :text             not null
#  name          :text             not null
#  icon          :text
#  required      :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ancestry      :string
#

class DataPart < ActiveRecord::Base
  belongs_to :subsection
  # belongs_to :data_part
  # has_many :children, class_name: :DataPart
  # belongs_to :parent, class_name: :DataPart, foreign_key: :data_part_id
  has_ancestry
end
