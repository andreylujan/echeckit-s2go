class Api::V1::ReportResource < JSONAPI::Resource
  attributes :title, :text, :organization_id
  def fetchable_fields
    super
  end
end
