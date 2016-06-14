# -*- encoding : utf-8 -*-
class Api::V1::ImageResource < JSONAPI::Resource
  
  attributes :url

	def url
		@model.image.url
	end  
  
  def fetchable_fields
    super
  end
end
