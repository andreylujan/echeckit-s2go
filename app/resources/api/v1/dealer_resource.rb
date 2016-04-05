class Api::V1::DealerResource < JSONAPI::Resource
  attributes :name

  has_many :zones
  has_many :stores
  
  def fetchable_fields
    super
  end
end
