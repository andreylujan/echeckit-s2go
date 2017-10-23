class ChecklistItem < ActiveRecord::Base
  acts_as_list scope: :checklist_id, top_of_list: 0
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
