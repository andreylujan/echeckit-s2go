class Api::V1::OrganizationResource < JSONAPI::Resource
  attributes :name
  def fetchable_fields
    super
  end
end
