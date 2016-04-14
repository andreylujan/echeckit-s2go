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
#  data_part_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DataPart < ActiveRecord::Base
  belongs_to :subsection
  belongs_to :data_part
  has_many :children, class_name: :DataPart
  belongs_to :parent, class_name: :DataPart
end
