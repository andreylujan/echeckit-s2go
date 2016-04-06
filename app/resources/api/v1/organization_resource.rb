class Api::V1::OrganizationResource < JSONAPI::Resource
  attributes :name
  has_many :roles
  def fetchable_fields
    super
  end
end
