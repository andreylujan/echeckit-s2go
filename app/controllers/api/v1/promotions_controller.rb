class Api::V1::PromotionsController < ApplicationController

  before_action :doorkeeper_authorize!
  include JSONAPI::ActsAsResourceController
 
  def context
    {
      current_user: current_user,
      all: params[:all]
    }
  end
  
  
end
