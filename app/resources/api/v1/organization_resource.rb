class Api::V1::OrganizationResource < JSONAPI::Resource
  attributes :name
  has_many :roles
  has_many :report_types
  
  def fetchable_fields
    super
  end
end
