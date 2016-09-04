# -*- encoding : utf-8 -*-
class Api::V1::ReportResource < JSONAPI::Resource
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

  filters :assigned_user_id, :finished, :dealer_ids, :zone_ids, :store_ids

  filter :creator_id, apply: ->(records, value, _options) {
    records.where('assigned_user_id is NULL')
  }

  filter :creator_id, apply: ->(records, value, _options) {
    records.where('assigned_user_id is NULL')
  }

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
