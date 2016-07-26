# == Schema Information
#
# Table name: daily_product_sales
#
#  id         :integer          not null, primary key
#  product_id :integer
#  store_id   :integer
#  sales_date :datetime         not null
#  quantity   :integer          not null
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DailyProductSale < ActiveRecord::Base
  belongs_to :product
  belongs_to :store
  validates :product, presence: true
  validates :store, presence: true
  validates :sales_date, presence: true

  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true
end
