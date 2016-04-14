# == Schema Information
#
# Table name: subsections
#
#  id             :integer          not null, primary key
#  section_id     :integer
#  name           :text             not null
#  icon           :text
#  has_pictures   :boolean          default(TRUE), not null
#  has_comment    :boolean          default(TRUE), not null
#  max_pictures   :integer          default(20), not null
#  comment_length :integer          default(256), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Subsection < ActiveRecord::Base
  belongs_to :section
  has_many :data_parts
end
