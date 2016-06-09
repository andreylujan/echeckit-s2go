# -*- encoding : utf-8 -*-
class Api::V1::ReportResource < JSONAPI::Resource
  attributes :dynamic_attributes, :creator_id, :created_at, :limit_date,
  :finished, :assigned_user_id, :pdf, :pdf_uploaded




  def custom_links(options)
    {self: nil}
  end

  def pdf
  	@model.pdf.url
  end

  def self.records(options = {})
    context = options[:context]
    user = context[:current_user]
    if user.role_id == 2 or !context[:all]
      user.viewable_reports
    else
      Report.where(organization: user.role.organization)
    end
  end

  filters :assigned_user_id
  
  filter :creator_id, apply: ->(records, value, _options) {
    records.where('assigned_user_id is NULL')
  }

  def fetchable_fields
    super
  end
end
