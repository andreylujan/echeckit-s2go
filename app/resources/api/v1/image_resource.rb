# -*- encoding : utf-8 -*-
class Api::V1::ImageResource < BaseResource
  
  attributes :url, :zone_name, :dealer_name, :store_name, :creator_name, :creator_email, :created_at, :comment,
    :report_uuid

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
