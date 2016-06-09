# -*- encoding : utf-8 -*-
class Api::V1::RoleResource < JSONAPI::Resource
  attributes :name
  def fetchable_fields
    super
  end
end
