# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: data_parts
#
#  id            :integer          not null, primary key
#  subsection_id :integer
#  type          :text             not null
#  name          :text             not null
#  icon          :text
#  required      :boolean          default(TRUE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  ancestry      :string
#

class CustomSerializer < DataPartSerializer
	attributes :data, :detail

	def detail
		if object.detail.present?
			DataPart.unscoped do
				SubsectionSerializer.new(object.detail).as_json
			end
		end
	end
end
