class Api::V1::SectionsController < ApplicationController

  before_action :doorkeeper_authorize!
  
  def index
  	organization_id = current_user.role.organization_id
  	@sections = Section.includes(subsections: [:data_parts]).where(organization_id: organization_id) 
  	render json: @sections, include: 'subsections.data_parts'
  end
end
