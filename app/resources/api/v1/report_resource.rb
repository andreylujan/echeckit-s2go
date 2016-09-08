# -*- encoding : utf-8 -*-
class Api::V1::ReportResource < BaseResource
  attributes :dynamic_attributes, :creator_id, :created_at, :limit_date,
    :finished, :assigned_user_id, :pdf, :pdf_uploaded,
    :task_start, :title, :description, :report_type_id,
    :store_name, :zone_name, :dealer_name, :assigned_user_name, :creator_name,
    :finished_at

  before_create :set_creator

  has_one :assigned_user
  has_one :store

  def custom_links(options)
    {self: nil}
  end

  def pdf
    @model.pdf.url
  end

  def set_creator(promotion = @model, context = @context)
    user = context[:current_user]
    promotion.creator = user
  end

  def self.records(options = {})
    context = options[:context]
    user = context[:current_user]

    if user.role_id == 2 or !context[:all]
      reports = user.viewable_reports
    else
      reports = Report.joins(creator: :role).where(roles: { organization_id: user.role.organization_id })
    end

    if context[:only_daily]
      reports = reports.where(assigned_user_id: nil, report_type_id: 1)
    elsif context[:only_assigned]
      reports = reports.where(report_type_id: 1)
      .where.not(assigned_user_id: nil)
    end

    if not options[:sort_criteria].present?
      reports = reports.order('created_at DESC')
    end
    reports
  end

  filters :assigned_user_id, :finished, :dealer_ids, :zone_ids, :store_ids,
    :title, :created_at, :limit_date, :task_start


  filter :created_at, apply: ->(records, value, _options) {
    records.where("to_char(reports.created_at, 'DD/MM/YYYY HH:MI') similar to '%(" + value.join("|") + ")%'")
  }

  filter :limit_date, apply: ->(records, value, _options) {
    records.where("to_char(reports.limit_date, 'DD/MM/YYYY HH:MI') similar to '%(" + value.join("|") + ")%'")
  }

  filter :task_start, apply: ->(records, value, _options) {
    records.where("to_char(reports.task_start, 'DD/MM/YYYY HH:MI') similar to '%(" + value.join("|") + ")%'")
  }

  filter :zone_name, apply: ->(records, value, _options) {
    records.includes(store: :zone).where("zones.name ILIKE ?", "%#{value.first}%")
  }

  filter :store_name, apply: ->(records, value, _options) {
    records.includes(:store).where('stores.name ILIKE ?', "%#{value.first}%")
  }

  filter :dealer_name, apply: ->(records, value, _options) {
    records.includes(store: :dealer).where("dealers.name ILIKE ?", "%#{value.first}%")
  }

  filter :creator_name, apply: ->(records, value, _options) {
    records.includes(:creator).where('users.first_name || users.last_name ILIKE ?', "%#{value.first}%")
    .references(:creator)
  }

  filter :assigned_user_name, apply: ->(records, value, _options) {
    records.includes(:assigned_user).where('assigned_users_reports.first_name || assigned_users_reports.last_name ILIKE ?', "%#{value.first}%")
    .references(:assigned_user)
  }


  filter :creator_id, apply: ->(records, value, _options) {
    records.where('assigned_user_id is NULL')
  }

  def self.apply_sort(records, order_options, context = {})
    if order_options.include?("zone_name")
      direction = order_options["zone_name"].to_s
      records = records.includes(store: :zone).order("zones.name #{direction}")
      order_options.delete "zone_name"
    end

    if order_options.include?("dealer_name")
      direction = order_options["dealer_name"].to_s
      records = records.includes(store: :dealer).order("dealers.name #{direction}")
      order_options.delete "zone_name"
    end

    if order_options.include?("store_name")
      direction = order_options["store_name"].to_s
      records = records.includes(:store).order("stores.name #{direction}")
      order_options.delete "store_name"
    end

    if order_options.include?("creator_name")
      direction = order_options["creator_name"].to_s
      records = records.includes(:creator).order("(users.first_name || users.last_name) #{direction}")
      order_options.delete "creator_name"
    end

    if order_options.include?("assigned_user_name")
      direction = order_options["assigned_user_name"].to_s
      records = records.includes(:assigned_user).order("(assigned_users_reports.first_name || assigned_users_reports.last_name) #{direction}")
      order_options.delete "assigned_user_name"
    end



    super(records, order_options, context)
  end



  filter :zone_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:store)
      .where(stores: { zone_id: value })
    else
      records
    end
  }
  filter :dealer_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:store)
      .where(stores: { dealer_id: value })
    else
      records
    end
  }
  filter :store_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:store)
      .where(stores: { id: value })
    else
      records
    end
  }

  def fetchable_fields
    super
  end
end
