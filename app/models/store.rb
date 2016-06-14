# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stores
#
#  id               :integer          not null, primary key
#  name             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  contact          :text
#  phone_number     :text
#  address          :text
#  zone_id          :integer
#  dealer_id        :integer
#  deleted_at       :datetime
#  monthly_goal_clp :integer
#  monthly_goal_usd :decimal(8, 2)
#  store_type_id    :integer
#

class Store < ActiveRecord::Base

    belongs_to :zone
    belongs_to :dealer

    acts_as_paranoid
    
    validates_presence_of [ :name, :zone, :dealer ]
    validates :monthly_goal_clp, numericality: { only_integer: true }
    validates :monthly_goal_usd, numericality: true

    belongs_to :store_type
end
