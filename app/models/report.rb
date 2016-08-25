# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: reports
#
#  id                 :integer          not null, primary key
#  organization_id    :integer          not null
#  report_type_id     :integer          not null
#  dynamic_attributes :json             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  creator_id         :integer          not null
#  limit_date         :datetime
#  finished           :boolean          default(FALSE), not null
#  assigned_user_id   :integer
#  pdf                :text
#  pdf_uploaded       :boolean          default(FALSE), not null
#  uuid               :text
#  store_id           :integer
#

class Report < ActiveRecord::Base

  belongs_to :organization
  belongs_to :report_type
  belongs_to :report_type
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :assigned_user, class_name: :User, foreign_key: :assigned_user_id
  mount_uploader :pdf, PdfUploader

  has_many :images, dependent: :destroy
  has_many :checklist_item_values, dependent: :destroy
  has_many :daily_head_counts, dependent: :destroy
  has_many :daily_sales, dependent: :destroy
  has_many :daily_product_sales, dependent: :destroy
  has_many :stock_break_events, dependent: :destroy

  before_save :cache_data
  before_create :check_pdf_uploaded
  
  validates :report_type_id, presence: true
  validates :report_type, presence: true
  default_scope { order('created_at DESC') }
  validate :limit_date_cannot_be_in_the_past

  after_commit :check_num_images, on: [ :create, :update ]
  after_commit :send_task_job, on: [ :create ]

  after_create :cache_attribute_names
  after_create :assign_store

  after_save :generate_statistics
  belongs_to :store

  acts_as_xlsx columns: [
    :id, 
    :report_type_name,
    :execution_date,
    :dealer_name,
    :zone_name,
    :store_code,
    :store_name,
    :store_supervisor,
    :store_instructor,
    :report_assigned_user,
    :communicated_prices,
    :communicated_promotions
  ]

  def self.destroy_statistics
    MonthlySale.destroy_all
    DailySale.destroy_all
    DailyProductSale.destroy_all
    DailyHeadCount.destroy_all
    ChecklistItemValue.destroy_all
    StockBreakEvent.destroy_all
  end

  def self.regenerate_statistics
    all.each do |report|
      report.generate_statistics
    end
  end

  def generate_statistics
    if not self.finished?
      return
    end
    update_monthly_sales
    update_daily_sales
    update_daily_product_sales
    update_head_counts
    record_checklist_data
    record_stock_breaks
  end

  def report_type_name
    self.report_type.name
  end

  def execution_date
    self.updated_at
  end

  def communicated_prices
    prices_checklist = checklist_item_values.find_by_data_part_id(144)
    if prices_checklist.present?
      prices_checklist.item_value
    end
  end

  def communicated_promotions
    promotions_checklist = checklist_item_values.find_by_data_part_id(145)
    if promotions_checklist.present?
      promotions_checklist.item_value
    end
  end

  def zone_name
    store.zone.name
  end

  def dealer_name
    store.dealer.name
  end

  def store_code
    store.code
  end

  def store_name
    store.name
  end

  def store_supervisor
    store.supervisor.email if store.supervisor.present?
  end

  def report_assigned_user
    if assigned_user.present?
      assigned_user.email
    else
      creator.email
    end
  end

  def store_instructor
    store.instructor.email if store.instructor.present?
  end

  def cache_attribute_names
    if self.store.present?
      self.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["name_zone"] = store.zone.name
      self.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["name_dealer"] = store.dealer.name
      self.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["name_store"] = store.name
      save!
    end
  end

  def record_checklist_data
    if dynamic_attributes["sections"].present? and
      dynamic_attributes["sections"][1].present? and
      dynamic_attributes["sections"][1]["data_section"].present? and
      dynamic_attributes["sections"][1]["data_section"][0].present? and
      dynamic_attributes["sections"][1]["data_section"][0]["protocolo"].present? and
      dynamic_attributes["sections"][1]["data_section"][0]["protocolo"]["checklist"].present?
      checklist = dynamic_attributes["sections"][1]["data_section"][0]["protocolo"]["checklist"]
      checklist.each do |item|
        if item.present? and (item["value"] == true or item["value"] == false)
          checklist_item = ChecklistItem.find_by_name!(item["name"])
          value = ChecklistItemValue.find_or_create_by! report: self, checklist_item: checklist_item,
            item_value: item["value"]
        end
      end
    end
  end

  def record_stock_breaks
    breaks = stock_breaks
    if breaks.present?
      breaks.each do |stock_break|
        quantity = stock_break["game_amount"]
        if quantity.present?
          product = Product.find(stock_break["game_id"])
          store_type = self.store.store_type
          product_classification = product.product_classification
          stock_break = StockBreak.find_by_dealer_id_and_store_type_id_and_product_classification_id(self.store.dealer_id,
                                                                                                     store_type.id, product_classification.id)

          if stock_break.present? and stock_break.stock_break >= quantity.to_i
            stock_break_date = created_at.beginning_of_day
            event = StockBreakEvent.find_or_initialize_by product: product,
              report: self, stock_break_date: stock_break_date
            event.quantity = quantity
            event.stock_break_quantity = stock_break.stock_break
            event.save!
          end
        end
      end
    end
    true
  end

  def group_by_date_criteria
    created_at.to_date
    # I18n.l(created_at, format: '%A %e').capitalize
  end

  def generate_pdf(regenerate=false)
    UploadPdfJob.set(wait: 3.seconds).perform_later(self.id, regenerate)
  end

  def send_task_job
    if self.assigned_user.present?
      SendTaskJob.perform_later(self.id)
    end
  end

  def check_pdf_uploaded
    if self.dynamic_attributes.nil?
      self.dynamic_attributes = {}
    end
    if self.dynamic_attributes["num_images"].nil? or self.dynamic_attributes["num_images"] == 0 or self.dynamic_attributes["num_images"] == "0"
      self.pdf_uploaded = true
    end
  end

  def check_num_images
    # Don't generate PDF for unfinished reports
    if not self.finished?
      return
    end
    if self.dynamic_attributes.nil?
      self.dynamic_attributes = {}
    end
    if self.dynamic_attributes["num_images"].nil? or self.dynamic_attributes["num_images"] == 0 or self.dynamic_attributes["num_images"] == "0"
      self.generate_pdf(false)
    end
  end

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def cache_data
    if self.dynamic_attributes.nil?
      self.dynamic_attributes = {}
    end
    self.dynamic_attributes[:creator_name] = self.creator.full_name
    self.dynamic_attributes[:report_type_name] = self.report_type.name
  end

  def zone_name
    Zone.find(self.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["zone"]).name
  end

  def store_name
    store.name
  end

  def dealer_name
    Dealer.find(self.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["dealer"]).name
  end

  def sales_info
    if dynamic_attributes["sections"].present? and
      dynamic_attributes["sections"][2].present? and
      dynamic_attributes["sections"][2]["data_section"].present? and
      dynamic_attributes["sections"][2]["data_section"][0].present? and
      dynamic_attributes["sections"][2]["data_section"][0]["ventas"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["ventas"]["amount_value"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["ventas"]["amount_value"][0].present?
      dynamic_attributes["sections"][2]["data_section"][0]["ventas"]["amount_value"][0]
    end
  end

  def product_sales
    if dynamic_attributes["sections"].present? and
      dynamic_attributes["sections"][2].present? and
      dynamic_attributes["sections"][2]["data_section"].present? and
      dynamic_attributes["sections"][2]["data_section"][0].present? and
      dynamic_attributes["sections"][2]["data_section"][0]["more_sale"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["more_sale"]["list"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["more_sale"]["list"]
    end
  end

  def sales_type_set_mapping
    {
      "vr_hardware" => :hardware_sales=,
      "vr_accesories" => :accessory_sales=,
      "vr_games" => :game_sales=
    }
  end

  def sales_type_get_mapping
    {
      "vr_hardware" => :hardware_sales,
      "vr_accesories" => :accessory_sales,
      "vr_games" => :game_sales
    }
  end

  def update_daily_product_sales
    sales = product_sales

    if sales.present?
      sales.each do |product_sale|
        product = Product.find(product_sale["game_id"])
        daily_sale = DailyProductSale.find_or_create_by! report: self, product: product,
          sales_date: DateTime.new(created_at.year, created_at.month, created_at.day)
        quantity = product_sale["game_amount"].to_i
        if daily_sale.quantity < quantity
          daily_sale.update_attributes! quantity: quantity
        end
      end
    end
  end

  def head_counts
    if dynamic_attributes["sections"].present? and
      dynamic_attributes["sections"][2].present? and
      dynamic_attributes["sections"][2]["data_section"].present? and
      dynamic_attributes["sections"][2]["data_section"][0].present? and
      dynamic_attributes["sections"][2]["data_section"][0]["hc_promociones"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["hc_promociones"]["amount_value"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["hc_promociones"]["amount_value"][0]
    end
  end

  def stock_breaks
    if dynamic_attributes["sections"].present? and
      dynamic_attributes["sections"][2].present? and
      dynamic_attributes["sections"][2]["data_section"].present? and
      dynamic_attributes["sections"][2]["data_section"][0].present? and
      dynamic_attributes["sections"][2]["data_section"][0]["stock_break"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["stock_break"]["list"].present?
      dynamic_attributes["sections"][2]["data_section"][0]["stock_break"]["list"]
    end
  end

  def assign_store
    self.store = Store.find(self.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["store"])
    save!
  end

  def update_head_counts
    counts = head_counts
    if counts.present?
      counts.each do |hc_type, hc|
        hc.each do |brand_data|
          brand = Brand.where("lower(name) = ?", brand_data["platform"].downcase).first
          if brand.present?
            daily_hc = DailyHeadCount.find_or_create_by! report: self, brand: brand,
              count_date: DateTime.new(created_at.year, created_at.month, created_at.day)
            if hc_type == "hc_promot_ft"
              if brand_data["value"].present? and brand_data["value"].to_i > daily_hc.num_full_time
                daily_hc.update_attributes! num_full_time: brand_data["value"].to_i
              end
            elsif hc_type == "hc_promot_pt"
              if brand_data["value"].present? and brand_data["value"].to_i > daily_hc.num_part_time
                daily_hc.update_attributes! num_part_time: brand_data["value"].to_i
              end
            end
          end
        end
      end
    end
  end

  def update_daily_sales
    sales = sales_info

    if sales.present?
      sales.each do |sales_type, type_data|
        type_data.each do |brand_sales|
          brand = Brand.where("lower(name) = ?", brand_sales["platform"].downcase).first
          if brand.present?
            daily_sale = DailySale.find_or_create_by! report: self, brand: brand,
              sales_date: DateTime.new(created_at.year, created_at.month, created_at.day)
            current_sales = daily_sale.send sales_type_get_mapping[sales_type]
            if current_sales < brand_sales["value"].to_i
              daily_sale.send sales_type_set_mapping[sales_type], brand_sales["value"].to_i
              daily_sale.save!
            end
          end
        end
      end
    end
  end

  def update_monthly_sales
    sales = sales_info

    if sales.present?
      sales.each do |sales_type, type_data|
        type_data.each do |brand_sales|
          brand = Brand.where("lower(name) = ?", brand_sales["platform"].downcase).first
          if brand.present?
            monthly_sale = MonthlySale.find_or_create_by! store: store, brand: brand,
              sales_date: DateTime.new(created_at.year, created_at.month)
            current_sales = monthly_sale.send sales_type_get_mapping[sales_type]
            if current_sales < brand_sales["value"].to_i
              monthly_sale.send sales_type_set_mapping[sales_type], brand_sales["value"].to_i
              monthly_sale.save!
            end
          end
        end
      end
    end
  end

  private
  def limit_date_cannot_be_in_the_past
    if limit_date.present? && limit_date < DateTime.now - 5.minutes
      errors.add(:limit_date, "No puede estar en el pasado")
    end
  end

end
