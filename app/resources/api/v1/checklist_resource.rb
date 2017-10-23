# -*- encoding : utf-8 -*-
class Api::V1::ChecklistResource < BaseResource
  attributes :name, :children

  def children
  	@model.checklist_items
  end
end
