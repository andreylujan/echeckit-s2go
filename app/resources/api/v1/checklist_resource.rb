# -*- encoding : utf-8 -*-
class Api::V1::ChecklistResource < BaseResource
  attributes :name, :children

  def children
  	json = []
  	@model.checklist_items.each do |item|
  		json << item.as_json({ standard: true })
  	end
  	json
  end
end
