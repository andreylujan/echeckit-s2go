class Api::V1::JsonApiController < ApplicationController

  include JSONAPI::ActsAsResourceController

  def context
    {current_user: current_user}
  end  
  
end
