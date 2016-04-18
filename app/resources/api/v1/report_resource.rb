class Api::V1::ReportResource < JSONAPI::Resource
  attributes :dynamic_attributes, :creator_id, :created_at, :limit_date,
  :finished, :assigned_user_id


  def custom_links(options)
    {self: nil}
  end

  def fetchable_fields
    super
  end
end
