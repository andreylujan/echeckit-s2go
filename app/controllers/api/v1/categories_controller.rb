class Api::V1::CategoriesController < ApplicationController

  before_action :doorkeeper_authorize!

  def index
  	categories = current_user.organization.categories
  	render json: categories
  end
end
