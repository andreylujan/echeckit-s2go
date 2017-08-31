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
#  deleted_at                :string
#  catalogued                :boolean          default(TRUE), not null
#

class Product < ActiveRecord::Base

  require 'csv_utils'

  acts_as_paranoid

  belongs_to :product_type
  belongs_to :product_classification
  belongs_to :platform
  validates :min_price, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: true
  validates_numericality_of :max_price,
    greater_than_or_equal_to: Proc.new { |product| product.min_price }, allow_nil: true

  validates :product_type, presence: true
  validates :product_classification, presence: true
  validates :name, presence: true
  validates :sku, uniqueness: true, allow_nil: true, allow_blank: true
  validates :plu, uniqueness: true, allow_nil: true, allow_blank: true
  has_many :images, as: :resource
  has_many :stock_break_events

  before_create :check_empty_values

  scope :catalogued, -> { where(catalogued: true) }

  def check_empty_values
    if plu == ""
      self.plu = nil
    end
    if sku == ""
      self.sku = nil
    end
  end

  def self.from_csv_path(csv_path, reset = false)
    Product.transaction do
      if reset
        Product.destroy_all
      end
      csv = CsvUtils.load_csv(csv_path, headers=false)
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
          is_listed: true, catalogued: true
        product.save!
        products << product
      end
      product_ids = products.map { |product| product.id }
      Product.where.not(id: product_ids).each do |product|
        product.update_attribute :catalogued, false
      end
      # CsvUtils.generate_response(csv, products)
      products
    end
  end

  def self.from_csv(csv_file, reset = false)
    header = "ean;description;classification;category;platform;publisher\n"
    csv_file = csv_file.open
    lines = csv_file.readlines
    csv_file.close
    lines[0] = header
    f = Tempfile.new('csv')
    f.write lines.join
    f.close
    from_csv_path(f.path, reset)

  end
end
