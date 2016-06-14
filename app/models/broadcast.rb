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
#  resource_id       :integer
#  send_at           :datetime
#  sent              :boolean
#

class Broadcast < ActiveRecord::Base
  belongs_to :message_action
  belongs_to :sender, foreign_key: :sender_id, class_name: :User
  has_many :messages, dependent: :destroy
  has_many :recipients, through: :messages, source: :user

  
  before_create :check_sent
  before_destroy :check_if_sent  
  after_commit :send_message, on: [ :create ]

  def send_messages
    if self.sent?
      SendMessageJob.perform_later(self.id)
    end
  end

  def check_sent
  	if self.send_at.nil?
  		self.sent = true
  	else
  		self.sent = false
  	end
  	true
  end

  def check_if_sent
  	unless not sent?
  		errors.add(:sent, "No se puede eliminar un mensaje que ya ha sido enviado")
      return false
  	end
    true
  end
end
