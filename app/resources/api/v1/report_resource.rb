class Api::V1::ReportResource < JSONAPI::Resource
  attributes :dynamic_attributes, :creator_id, :created_at
  
  def fetchable_fields
    super
  end
end
