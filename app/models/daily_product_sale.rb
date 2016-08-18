# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: daily_product_sales
#
#  id         :integer          not null, primary key
#  product_id :integer
#  store_id   :integer
#  sales_date :datetime         not null
#  quantity   :integer          default(0), not null
#  amount     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DailyProductSale < ActiveRecord::Base
  belongs_to :product
  belongs_to :store
  validates :product, presence: true
  validates :store, presence: true
  validates :sales_date, presence: true

  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true

  acts_as_xlsx columns: [ :id, :product_id, :dealer_name, :zone_name, :date,
                          :store_code, 
                          :store_name, :product_name, :product_ean, 
                          :product_classification_name, 
                          :quantity, :amount ]

  def date
    sales_date.to_date
  end

  def zone_name
    store.zone.name
  end

  def product_name
  	product.name
  end

  def product_ean
  	product.sku
  end

  def dealer_name
    store.dealer.name
  end

  def store_code
    store.code
  end

  def product_classification_name
    product.product_classification.name
  end

  def store_name
    store.name
  end
end
