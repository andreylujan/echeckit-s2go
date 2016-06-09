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
#

class Checkin < ActiveRecord::Base

  belongs_to :user
  validates_presence_of [ :user, :arrival_time ]
  before_validation :set_arrival_time, on: :create
  # before_create :fill_data_attributes
  after_create :send_checkin_email
  after_save :send_checkout_email, if: :exit_time_changed?

  def set_arrival_time
  	self.arrival_time = DateTime.now
  end

  def longitude
  	
  end

  def latitude
  end

  def formatted_arrival_time
    if arrival_time.present?
      tz = ActiveSupport::TimeZone.new("Santiago")
      arrival_time.in_time_zone(tz).strftime("%H:%M")
    end
  end

  def formatted_arrival_date
    if arrival_time.present?
      tz = ActiveSupport::TimeZone.new("Santiago")
      arrival_time.in_time_zone(tz).strftime("%d/%m/%y")
    end
  end

  def formatted_exit_time
    if exit_time.present?
      tz = ActiveSupport::TimeZone.new("Santiago")
      exit_time.in_time_zone(tz).strftime("%H:%M")
    end
  end

  def formatted_exit_date
    if exit_time.present?
      tz = ActiveSupport::TimeZone.new("Santiago")
      exit_time.in_time_zone(tz).strftime("%d/%m/%y")
    end
  end

  def zone_name
    if data["zone_name"]
      data["zone_name"]
    elsif data["zone_id"]
      Zone.find(data["zone_id"]).name
    end
  end

  def store_name
    if data["store_name"]
      data["store_name"]
    elsif data["store_id"]
      Store.find(data["store_id"]).name
    end
  end

  def dealer_name
    if data["dealer_name"]
      data["dealer_name"]
    elsif data["dealer_id"]
      Dealer.find(data["dealer_id"]).name
    end
  end

  def send_checkin_email
    UserMailer.delay.checkin_email(self)
  end

  def send_checkout_email
    if exit_time.present?
      UserMailer.delay.checkout_email(self)
    end
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
