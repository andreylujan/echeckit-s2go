# == Schema Information
#
# Table name: monthly_sales
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  sales_date      :datetime         not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  hardware_sales  :integer          default(0), not null
#  accessory_sales :integer          default(0), not null
#  game_sales      :integer          default(0), not null
#  brand_id        :integer          not null
#

class MonthlySale < ActiveRecord::Base
  belongs_to :store
  belongs_to :brand
  validates :store, presence: true
  validates :brand, presence: true
  validates :sales_date, presence: true
  validates :hardware_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :accessory_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :game_sales, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
end
