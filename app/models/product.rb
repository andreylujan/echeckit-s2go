# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: products
#
#  id                        :integer          not null, primary key
#  name                      :text             not null
#  description               :text
#  sku                       :text
#  plu                       :text
#  validity_code             :text
#  product_type_id           :integer          not null
#  brand                     :text
#  min_price                 :integer
#  max_price                 :integer
#  product_classification_id :integer          not null
#  is_top                    :boolean          default(FALSE), not null
#  is_listed                 :boolean          default(FALSE), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  platform_id               :integer
#  publisher                 :text
#

class Product < ActiveRecord::Base

  require 'csv_utils'

  belongs_to :product_type
  belongs_to :product_classification
  belongs_to :platform
  validates :min_price, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true
  validates_numericality_of :max_price,
    greater_than_or_equal_to: Proc.new { |product| product.min_price }, allow_nil: true

  validates :product_type, presence: true
  validates :product_classification, presence: true
  validates :name, presence: true
  validates :sku, uniqueness: true, allow_nil: true
  validates :plu, uniqueness: true, allow_nil: true
  has_many :images, as: :resource
  has_many :stock_break_events

  default_scope { order('name ASC') }

  def self.from_csv(csv_path, reset = false)
    Product.transaction do
      if reset
        Product.destroy_all
      end
      csv = CsvUtils.load_csv(csv_path)
      csv.shift
      products = []
      csv.each do |row|
        product = Product.find_or_initialize_by(sku: row[0])
        name = row[1]
        classification = ProductClassification.find_or_create_by_lowercase_name! row[2]
        product_type = ProductType.find_or_create_by_lowercase_name! row[3]
        platform = Platform.find_or_create_by_lowercase_name! row[4]
        publisher = row[5]
        product.assign_attributes name: name, product_classification: classification,
          product_type: product_type, platform: platform, publisher: publisher,
          is_listed: true
        product.save!
        products << product
      end
      products
    end
  end
end
