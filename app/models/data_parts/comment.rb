# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: data_parts
#
#  id              :integer          not null, primary key
#  subsection_id   :integer
#  type            :text             not null
#  name            :text             not null
#  icon            :text
#  required        :boolean          default(TRUE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ancestry        :string
#  max_images      :integer
#  max_length      :integer
#  data            :json             not null
#  position        :integer          default(0), not null
#  detail_id       :integer
#  organization_id :integer
#

class Comment < DataPart
    
end
