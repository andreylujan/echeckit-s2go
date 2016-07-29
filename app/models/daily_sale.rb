class DailySale < ActiveRecord::Base
  belongs_to :store
  belongs_to :brand
  validates :store, presence: true
  validates :brand, presence: true
  validates :sales_date, presence: true
  validates :hardware_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :accessory_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :game_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
end
