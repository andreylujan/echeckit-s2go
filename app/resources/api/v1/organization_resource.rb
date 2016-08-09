# -*- encoding : utf-8 -*-
class Api::V1::OrganizationResource < JSONAPI::Resource
  attributes :name
  has_many :roles
  has_many :report_types
  
  def fetchable_fields
    super
  end

  def records_for(relation_name)
  	if relation_name == :report_types
  		@model.report_types.order("id ASC")
  	else
  		super
  	end
  end
end
