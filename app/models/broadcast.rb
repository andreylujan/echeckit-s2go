# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: broadcasts
#
#  id                :integer          not null, primary key
#  title             :text
#  html              :text
#  sender_id         :integer
#  message_action_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Broadcast < ActiveRecord::Base
  belongs_to :message_action
  belongs_to :sender, foreign_key: :sender_id, class_name: :User
  has_many :messages
end
