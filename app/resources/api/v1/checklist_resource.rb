# -*- encoding : utf-8 -*-
class Api::V1::ChecklistResource < JSONAPI::Resource
  attributes :name, :children
end
