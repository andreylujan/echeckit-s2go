# -*- encoding : utf-8 -*-
class Api::V1::ImageResource < BaseResource
  
  attributes :url
  has_one :category
  has_one :resource
  has_one :gallery
  
	def url
		@model.image.url
	end  

	def custom_links(options)
    	{self: nil}
  	end
  
  def fetchable_fields
    super
  end
end
