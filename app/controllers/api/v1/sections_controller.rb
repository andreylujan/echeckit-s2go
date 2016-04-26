class Api::V1::SectionsController < ApplicationController

  before_action :doorkeeper_authorize!
  
  def index  	
  	report_type_id = params.require(:report_type_id)
  	@sections = ReportType.includes(sections: [ :section_type, subsections: [:data_parts]])
  	.find(report_type_id).sections
  	
  	render json: @sections, include: 'subsections.data_parts'
  end
end
