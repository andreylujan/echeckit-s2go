# == Schema Information
#
# Table name: checklist_items
#
#  id           :integer          not null, primary key
#  name         :text             not null
#  required     :boolean          default(FALSE), not null
#  position     :integer
#  data         :jsonb            not null
#  checklist_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ChecklistItem < ActiveRecord::Base
  acts_as_list scope: :checklist_id, top_of_list: 0
  belongs_to :checklist
  def option_ids
    self.data["option_ids"]
  end

  def options
    self.data["options"]
  end
  def as_json(opts)
  	ChecklistItemSerializer.new(self).as_json
  end
  def type
  	"ChecklistItem"
  end
  def icon
  	nil
  end

end
