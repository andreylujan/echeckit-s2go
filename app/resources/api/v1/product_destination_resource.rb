# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: product_destinations
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Api::V1::ProductDestinationResource < BaseResource
	attributes :name
end