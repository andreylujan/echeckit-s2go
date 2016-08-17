# == Schema Information
#
# Table name: weekly_business_sales
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  business_week   :integer          not null
#  month           :integer          not null
#  hardware_sales  :integer          default(0), not null
#  accessory_sales :integer          default(0), not null
#  game_sales      :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class WeeklyBusinessSale < ActiveRecord::Base
  belongs_to :store
  validates :store, presence: true
  validates :hardware_sales, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: false
  validates :accessory_sales, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :game_sales, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :month, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12, only_integer: true},
    alloy_nil: false
  validates :business_week, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 53, only_integer: true},
    alloy_nil: false

  acts_as_xlsx columns: [ :id, :dealer_name, :zone_name,
                          :store_code,
                          :store_name, :month_number, :hardware_sales, :accessory_sales,
                          :week_number,
                          :game_sales,
                          :year
                          ]

  def week_number
    strftime("%U")
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


  def store_code
    store.code
  end
end
