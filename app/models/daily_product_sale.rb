# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: daily_product_sales
#
#  id         :integer          not null, primary key
#  product_id :integer
#  quantity   :integer          default(0), not null
#  amount     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  report_id  :integer
#

class DailyProductSale < ActiveRecord::Base
  belongs_to :product
  belongs_to :report
  validates :product, presence: true
  validates :report, presence: true
  
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true

  acts_as_xlsx columns: [ :id, :report_id, :report_date, :store_supervisor, :store_instructor, 
                          :report_assigned_user, :product_id, :dealer_name, :zone_name, :date,
                          :store_code,
                          :store_name, :product_name, :product_ean,
                          :product_classification_name,
                          :quantity, :amount ]

  def store_supervisor
    store.supervisor.email if store.supervisor.present?
  end

  def report_assigned_user
    if report.assigned_user.present?
      report.assigned_user.email
    else
      report.creator.email
    end
  end

  def sales_date
    report.created_at
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

  def product_store_criteria
    [ product, store ]
  end

  def store_code
    store.code
  end

  def product_classification_name
    product.product_classification.name
  end

  def product_type_criteria
    product.product_type_id
  end

  def store_name
    store.name
  end
end
