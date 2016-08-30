# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: promotion_states
#
#  id           :integer          not null, primary key
#  promotion_id :integer          not null
#  store_id     :integer          not null
#  activated_at :datetime
#  report_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  deleted_at   :datetime
#

class PromotionState < ActiveRecord::Base
  belongs_to :promotion
  belongs_to :store
  belongs_to :report
  validates :promotion, presence: true
  validates :store, presence: true

  acts_as_paranoid
  
  def activated
  	self.activated_at.present?
  end

  def store_name
  	store.name
  end

  def dealer_name
  	store.dealer.name
  end

  def zone_name
  	store.zone.name
  end

  def pdf
  	report.pdf_url if report.present?
  end

  def pdf_uploaded
  	report.pdf_uploaded if report.present?
  end

  def activator_name
  	report.creator.name if report.present?
  end

  def creator_name
  	promotion.creator.name
  end

  def start_date
    promotion.start_date
  end

  def end_date
    promotion.end_date
  end
   
   def title
    promotion.title
   end

end
