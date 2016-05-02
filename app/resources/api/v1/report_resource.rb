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
    user.viewable_reports
  end

  def fetchable_fields
    super
  end
end
