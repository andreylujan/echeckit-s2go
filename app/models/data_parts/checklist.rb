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

class Checklist < DataPart
	has_many :promotions
    def options
    	org_id = self.subsection.section.organization_id    	
    	ChecklistOption.unscoped.where(organization_id: org_id)    	
	end

	def children=(val)
		old_children = []
		new_children = []
		val.each_with_index do |item_attrs, idx|
			if item_attrs[:id].present?
				old_children << ChecklistItem.find(item_attrs[:id])
			else
				new_children << item_attrs.merge({ type: "ChecklistItem", 
					organization_id: self.organization_id
				})
			end
		end
		save!

		self.children.each do | c |
			c.update_attribute :parent, nil
		end

		old_children.each do | old |
			old.update_attribute :parent, self
		end

		new_children.each do | new |
			self.children.create! new
		end
	end
end
