# == Schema Information
#
# Table name: subsection_items
#
#  id                      :integer          not null, primary key
#  subsection_item_type_id :integer          not null
#  subsection_id           :integer          not null
#  has_details             :boolean          not null
#  name                    :text             not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class SubsectionItem < ActiveRecord::Base
  belongs_to :subsection_item_type
  belongs_to :subsection
end
