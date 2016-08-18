# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_break_events
#
#  id               :integer          not null, primary key
#  store_id         :integer          not null
#  product_id       :integer          not null
#  quantity         :integer          not null
#  stock_break_date :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StockBreakEvent < ActiveRecord::Base
  belongs_to :report
  belongs_to :product
  validates :report, presence: true
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :stock_break_date, presence: true
  validates :product, presence: true

  acts_as_xlsx columns: [ :id, :dealer_name,
                          :zone_name,
                          :store_code,
                          :store_name,
                          :product_classification_name,
                          :product_ean,
                          :product_name,
                          :quantity,
                          :created_at ]

  def store
    report.store
  end
  
  def dealer_name
    store.dealer.name
  end

  def zone_name
    store.zone.name
  end

  def store_code
    store.code
  end

  def store_name
    store.name
  end

  def product_ean
    product.sku
  end

  def product_name
    product.name
  end

  def product_classification_name
    product.product_classification.name
  end

  def group_by_month_criteria
    DateTime.new(stock_break_date.year, stock_break_date.month)
  end

  def group_by_store_criteria
    [ store, product ]
  end
end
