# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: section_types
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SectionType < ActiveRecord::Base
    has_many :sections
end
