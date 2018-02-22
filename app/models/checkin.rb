# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: checkins
#
#  id             :integer          not null, primary key
#  user_id        :integer          not null
#  arrival_time   :datetime         not null
#  exit_time      :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  data           :json             not null
#  arrival_lonlat :geometry({:srid= point, 0
#  exit_lonlat    :geometry({:srid= point, 0
#  store_id       :integer
#

class Checkin < ActiveRecord::Base

  belongs_to :user
  validates_presence_of [ :user, :arrival_time ]
  before_validation :set_arrival_time, on: :create
  # before_create :fill_data_attributes
  after_create :send_checkin_email
  after_save :send_checkout_email, if: :exit_time_changed?
  before_create :assign_store
  belongs_to :store

  acts_as_xlsx columns: [
    :id,
    :user_email,
    :user_full_name,
    :dealer_name,
    :zone_name,
    :store_code,
    :store_name,
    :arrival_time,
    :exit_time,
    :hours_worked
  ]

  def hours_worked
    if exit_time.present?
      ((exit_time - arrival_time)/1.hour).round(1)
    end
  end

  def user_email
    user.email if self.user.present?
  end

  def user_full_name
    user.full_name
  end

  def group_by_date_criteria
    arrival_time.to_date
    # I18n.l(created_at, format: '%A %e').capitalize
  end

  def set_arrival_time
    self.arrival_time = DateTime.now
  end

  def longitude

  end

  def latitude
  end

  def formatted_arrival_time
    if arrival_time.present?
      tz = ActiveSupport::TimeZone.new("America/Panama")
      arrival_time.in_time_zone(tz).strftime("%H:%M")
    end
  end

  def formatted_arrival_date
    if arrival_time.present?
      tz = ActiveSupport::TimeZone.new("America/Panama")
      arrival_time.in_time_zone(tz).strftime("%d/%m/%y")
    end
  end

  def formatted_exit_time
    if exit_time.present?
      tz = ActiveSupport::TimeZone.new("America/Panama")
      exit_time.in_time_zone(tz).strftime("%H:%M")
    end
  end

  def formatted_exit_date
    if exit_time.present?
      tz = ActiveSupport::TimeZone.new("America/Panama")
      exit_time.in_time_zone(tz).strftime("%d/%m/%y")
    end
  end

  def check_store
    if self.store.nil?
      self.store = Store.find_by_id(data["store_id"])
      save!
    end
  end

  def store_code
    check_store
    store.code
  end

  def zone_name
    check_store
    store.zone.name
  end

  def store_name
    check_store
    store.name
  end

  def dealer_name
    check_store
    store.dealer.name
  end

  def send_checkin_email
    UserMailer.delay(queue: "#{ENV['QUEUE_PREFIX']}_email").checkin_email(self)
  end

  def send_checkout_email
    if exit_time.present?
      UserMailer.delay(queue: "#{ENV['QUEUE_PREFIX']}_email").checkout_email(self)
    end
  end

  def assign_store
    self.store = Store.find_by_id(data["store_id"])
  end

  private



  def fill_data_attributes
    if data["zone_id"].present?
      data["zone_name"] = Zone.find(data["zone_id"]).name
    end

    if data["store_id"].present?
      data["store_name"] = Store.find(data["store_id"]).name
    end

    if data["dealer_id"].present?
      data["dealer_name"] = Zone.find(data["dealer_id"]).name
    end
  end




end
