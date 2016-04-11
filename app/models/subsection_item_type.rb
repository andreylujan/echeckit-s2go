# == Schema Information
#
# Table name: subsection_item_types
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubsectionItemType < ActiveRecord::Base
    has_many :subsection_items
end
