class Api::V1::TopListsController < ApplicationController

  before_action :doorkeeper_authorize!
  
  def show
  	top_list = current_user.organization.top_lists.last
  	render json: top_list, include: [ :top_list_items ]
  end

end
