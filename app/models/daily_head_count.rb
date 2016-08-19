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
  belongs_to :report
  belongs_to :brand

  validates :report, presence: true
  validates :brand, presence: true

  validates :num_full_time, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :num_part_time, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false

  acts_as_xlsx columns: [ :id,
                          :dealer_name,
                          :zone_name,
                          :store_code,
                          :store_name,
                          :brand_name,
                          :num_full_time,
                          :num_part_time,
                          :report_date,
                          :store_supervisor,
                          :store_instructor,
                          :report_assigned_user ]

  def store_supervisor
    store.supervisor.email if store.supervisor.present?
  end

  def report_date
    report.updated_at
  end

  def report_assigned_user
    if report.assigned_user.present?
      report.assigned_user.email
    else
      report.creator.email
    end
  end

  def store_instructor
    store.instructor.email if store.instructor.present?
  end


  def store
    report.store
  end

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
