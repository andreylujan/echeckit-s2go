# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: data_parts
#
#  id              :integer          not null, primary key
#  subsection_id   :integer
#  type            :text             not null
#  name            :text             not null
#  icon            :text
#  required        :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ancestry        :string
#  max_images      :integer
#  max_length      :integer
#  data            :json             not null
#  position        :integer          default(0), not null
#  detail_id       :integer
#  organization_id :integer
#

class Checklist < ActiveRecord::Base
	acts_as_list
    def options
    	org_id = self.subsection.section.organization_id    	
    	ChecklistOption.all   	
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

		self.children.each do | c |
			if not old_children.include?(c)
				c.update_attribute :parent, nil
			else
				old = old_children.find { |old| old.id == c.id }
				old.save!
			end
		end


		new_children.each do | new |
			self.children.create! new
		end
	end
end
