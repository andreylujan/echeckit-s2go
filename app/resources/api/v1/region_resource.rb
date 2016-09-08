# -*- encoding : utf-8 -*-
class Api::V1::RegionResource < BaseResource
    
  attributes :name

  def fetchable_fields
    super
  end
end
