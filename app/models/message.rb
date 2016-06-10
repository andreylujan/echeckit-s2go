# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  broadcast_id :integer          not null
#  user_id      :integer          not null
#  read         :boolean          default(FALSE), not null
#  read_at      :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Message < ActiveRecord::Base

  acts_as_paranoid

  belongs_to :broadcast
  belongs_to :user

  validates :user, presence: true
  validates :broadcast, presence: true
end
