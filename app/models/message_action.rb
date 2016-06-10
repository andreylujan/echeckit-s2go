# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: message_actions
#
#  id              :integer          not null, primary key
#  organization_id :integer
#  name            :text             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  resource_id     :integer
#

class MessageAction < ActiveRecord::Base
  belongs_to :organization
end
