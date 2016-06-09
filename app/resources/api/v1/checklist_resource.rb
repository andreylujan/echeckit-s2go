# -*- encoding : utf-8 -*-
class Api::V1::ChecklistResource < JSONAPI::Resource
  has_many :promotions
end
