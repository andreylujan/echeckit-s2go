# -*- encoding : utf-8 -*-
class BaseResource < JSONAPI::Resource
    def custom_links(options)
    	{self: nil}
  	end
end
