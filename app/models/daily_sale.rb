# == Schema Information
#
# Table name: daily_sales
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  brand_id        :integer          not null
#  sales_date      :datetime         not null
#  hardware_sales  :integer          default(0), not null
#  accessory_sales :integer          default(0), not null
#  game_sales      :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class DailySale < ActiveRecord::Base
  belongs_to :store
  belongs_to :brand
  validates :store, presence: true
  validates :brand, presence: true
  validates :sales_date, presence: true
  validates :hardware_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :accessory_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :game_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  acts_as_xlsx columns: [ :id, :dealer_name, :zone_name,
      :store_name, :brand_name, :sales_date, :hardware_sales, :accessory_sales,
    :game_sales ]

  def dealer_criteria
    store.dealer
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

  def week_criteria
    start_day = :monday
    date = sales_date.to_date
    week_start_format = '%W'

    month_week_start = Date.new(date.year, date.month, 1)
    month_week_start_num = month_week_start.strftime(week_start_format).to_i
    month_week_start_num += 1 if month_week_start.wday > 4 # Skip first week if doesn't contain a Thursday

    month_week_index = date.strftime(week_start_format).to_i - month_week_start_num
    month_week_index + 1 # Add 1 so that first week is 1 and not 0

  end

  def month_criteria
  	sales_date.month
  end
end
