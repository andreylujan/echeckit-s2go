# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: daily_head_counts
#
#  id            :integer          not null, primary key
#  store_id      :integer
#  count_date    :datetime
#  num_full_time :integer          default(0), not null
#  num_part_time :integer          default(0), not null
#  brand_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DailyHeadCount < ActiveRecord::Base
  belongs_to :store
  belongs_to :brand

  validates :store, presence: true
  validates :brand, presence: true

  validates :num_full_time, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :num_part_time, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false

  acts_as_xlsx columns: [ :id, :dealer_name, :zone_name, :store_code,
                          :store_name, :brand_name, :num_full_time, :num_part_time,
                          :count_date ]


  def zone_name
    store.zone.name
  end

  def dealer_name
    store.dealer.name
  end

  def store_name
    store.name
  end

  def brand_name
    brand.name
  end

  def store_code
    store.code
  end

  def group_by_dealer_criteria
    store.dealer
    # I18n.l(created_at, format: '%A %e').capitalize
  end

  def group_by_store_criteria
    store
    # I18n.l(created_at, format: '%A %e').capitalize
  end
end
