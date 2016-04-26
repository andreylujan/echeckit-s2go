# == Schema Information
#
# Table name: subsections
#
#  id         :integer          not null, primary key
#  section_id :integer
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Subsection < ActiveRecord::Base
  belongs_to :section
  has_many :data_parts, -> { order(position: :asc) }
  has_many :checklist_options, class_name: :ChecklistOption, foreign_key: :detail_id
end
