# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: promotions
#
#  id           :integer          not null, primary key
#  start_date   :datetime         not null
#  end_date     :datetime         not null
#  title        :text             not null
#  html         :text             not null
#  checklist_id :integer
#  creator_id   :integer          not null
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Promotion < ActiveRecord::Base
	acts_as_paranoid
	belongs_to :creator, class_name: :User, foreign_key: :creator_id
	belongs_to :checklist
	validates_presence_of [ :start_date, :end_date, :title, :html, :creator  ]
	after_commit :send_promotion_job, on: [ :create ]
	has_and_belongs_to_many :users
	has_and_belongs_to_many :zones
	has_and_belongs_to_many :dealers
	has_many :images, as: :resource
	has_many :promotion_states, dependent: :destroy
	after_create :create_promotion_states

	def send_promotion_job
		SendPromotionJob.perform_later(self.id)
	end

	def create_promotion_states
		stores = Store.all
		if dealers.count > 0
			stores = stores.where(dealer_id: dealer_ids)
		end
		if zones.count > 0
			stores = stores.where(zone_id: zone_ids)
		end
		stores.each do |store|
			PromotionState.create! store: store,
				promotion: self
		end

	end
end
