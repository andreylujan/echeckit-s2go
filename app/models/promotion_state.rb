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

  def activator_email
  	report.creator.email if report.present?
  end

  def creator_email
    if promotion.nil?
      byebug
      a = 2
    end
  	promotion.creator.email
  end
   

end
