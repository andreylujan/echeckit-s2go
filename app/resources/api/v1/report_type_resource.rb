class Api::V1::ReportTypeResource < JSONAPI::Resource
  attributes :name
  
  def fetchable_fields
    super
  end
end
