# == Schema Information
#
# Table name: sections
#
#  id              :integer          not null, primary key
#  position        :integer
#  name            :text
#  organization_id :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  section_type_id :integer          not null
#

class Section < ActiveRecord::Base
  belongs_to :organization
  belongs_to :section_type
  has_many :subsections
  has_and_belongs_to_many :report_types
end
