# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: checklists
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  position   :integer
#  icon       :text
#  required   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Checklist < ActiveRecord::Base
	acts_as_list
	has_many :checklist_items, -> { order(position: :asc) }
    def options
    	org_id = self.subsection.section.organization_id    	
    	ChecklistOption.all   	
	end

	def type
		'Checklist'
	end

	def children=(val)
		old_children = []
		new_children = []
		val.each_with_index do |item_attrs, idx|
			if item_attrs[:id].present?
				item = ChecklistItem.find(item_attrs[:id])				
				item.assign_attributes(item_attrs)
				old_children << item
			else
				new_children << item_attrs.merge({ type: "ChecklistItem", 
					organization_id: self.organization_id
				})
			end
		end
		save!

		self.checklist_items.each do | c |
			if not old_children.include?(c)
				c.update_attribute :parent, nil
			else
				old = old_children.find { |old| old.id == c.id }
				old.save!
			end
		end


		new_children.each do | new |
			self.checklist_items.create! new
		end
	end
end
