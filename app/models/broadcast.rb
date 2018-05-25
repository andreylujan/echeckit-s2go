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
#  deleted_at        :datetime
#  action_text       :text
#  dealers           :json
#  stores            :json
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
  before_create :create_individual_messages

  def create_individual_messages
    if self.send_to_all?
      self.recipients = User.all
      Rails.logger.info "recipients : #{self.recipients}"
    end
    if self.dealers.present?
      if dealers.length == 0
        Dealer.all.map do |dealer|
          dealer.stores.map do |store|
            self.recipients << store.promoters
            self.recipients << store.instructor
            self.recipients << store.supervisor
          end
        end
      else
        self.dealers.map do |dealer|
          Dealer.find(dealer[:id]).stores.map do |store|
            s = Store.find(store)
            s.promoters.present? ? self.recipients << s.promoters : self.recipients
            s.instructor.present? ? self.recipients << s.instructor : self.recipients
            s.supervisor.present? ? self.recipients << s.supervisor : self.recipients
            #self.recipients << Store.find(store).promoters
            #self.recipients << Store.find(store).instructor
            #self.recipients << Store.find(store).supervisor

          end
        end
      end
    end
    if self.stores.present?
      if stores.length == 0
        Stores.all.map do |store|
          self.recipients << store.promoters
          self.recipients << store.instructor
          self.recipients << store.supervisor
        end
      else
        self.stores do |stores|
          s = Store.find(store[:id])
          s.promoters.present? ? self.recipients << s.promoters : self.recipients
          s.instructor.present? ? self.recipients << s.instructor : self.recipients
          s.supervisor.present? ? self.recipients << s.supervisor : self.recipients

          #self.recipients << Store.find(store).promoters
          #self.recipients << Store.find(store).instructor
          #self.recipients << Store.find(store).supervisor
        end
      end
    end
    Rails.logger.info "recipients : #{self.recipients.count}"
  end

  def check_send_to_all
    if not self.send_to_all? and recipients.length == 0
      errors.add(:recipients, "Debe ingresar al menos un usuario si no envía a todos")
    end
  end

  def send_messages
    if self.is_immediate?
      SendBroadcastJob.set(queue: "#{ENV['QUEUE_PREFIX']}_push").perform_later(self.id)
    else
      SendBroadcastJob.set(wait_until: self.send_at,
        queue: "#{ENV['QUEUE_PREFIX']}_push")
        .perform_later(self.id)
    end
  end

  def message_action_name
    if self.message_action.present?
      self.message_action.name
    end
  end

  def check_sent
  	if self.is_immediate?
  		self.sent = true
  	else
  		self.sent = false
  	end
  	true
  end

end
