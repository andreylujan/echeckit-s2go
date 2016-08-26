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
#  send_to_all       :boolean          default(FALSE), not null
#  is_immediate      :boolean          default(FALSE), not null
#

class Broadcast < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :message_action
  belongs_to :sender, foreign_key: :sender_id, class_name: :User
  has_many :messages, dependent: :destroy
  has_many :recipients, through: :messages, source: :user

  validates :send_to_all, :inclusion => {:in => [true, false]}
  validates :is_immediate, :inclusion => {:in => [true, false]}

  before_create :check_sent
  after_commit :send_messages, on: [ :create ]

  validate :check_send_to_all

  def check_send_to_all
    if not self.send_to_all? and recipients.length == 0
      errors.add(:recipients, "Debe ingresar al menos un usuario si no envía a todos")
    end
  end

  def send_messages
    if self.sent?
      SendBroadcastJob.perform_later(self.id)
    else
      SendBroadcastJob.set(wait_until: self.send_at)
        .perform_later(self.id)
    end
  end

  def message_action_name
    if self.message_action.present?
      self.message_action.name
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

end
