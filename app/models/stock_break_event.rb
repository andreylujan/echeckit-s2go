# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_break_events
#
#  id                   :integer          not null, primary key
#  product_id           :integer          not null
#  quantity             :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  stock_break_quantity :integer
#  report_id            :integer
#

class StockBreakEvent < ActiveRecord::Base
  belongs_to :report
  belongs_to :product
  validates :report, presence: true
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :product, presence: true

  acts_as_xlsx columns: [ :id,
                          :report_id,
                          :report_date,
                          :store_supervisor,
                          :store_instructor,
                          :report_creator,
                          :dealer_name,
                          :zone_name,
                          :store_code,
                          :store_name,
                          :product_classification_name,
                          :product_ean,
                          :product_name,
                          :quantity,
                          :stock_break_quantity,
                          :created_at ]


  def store_supervisor
    store.supervisor.email if store.supervisor.present?
  end

  def report_creator
    report.creator.email
  end

  def store_instructor
    store.instructor.email if store.instructor.present?
  end

  def report_date
    report.created_at.to_date
  end

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
    DateTime.new(report.created_at.year, report.created_at.month)
  end

  def group_by_store_criteria
    [ store, product ]
  end

  def group_by_product_criteria
    product
  end

  def group_by_dealer_criteria
    store.dealer
  end
end
