class Api::V1::ZoneResource < JSONAPI::Resource
    
  attributes :name

  has_many :dealers
  has_many :stores

  def fetchable_fields
    super
  end
end
