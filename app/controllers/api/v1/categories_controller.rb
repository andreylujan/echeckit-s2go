class Api::V1::CategoriesController < Api::V1::JsonApiController

  before_action :doorkeeper_authorize!

 
end
