# -*- encoding : utf-8 -*-
class Api::V1::SubsectionsController < ApplicationController
	before_action :doorkeeper_authorize!
	def index
		org_id = current_user.role.organization_id
		subsections = Subsection.joins(:section).where(sections: { organization_id: org_id })
		render json: subsections
	end
end
