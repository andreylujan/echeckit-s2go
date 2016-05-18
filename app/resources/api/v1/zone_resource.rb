class Api::V1::ZoneResource < JSONAPI::Resource
    
  attributes :name, :dealer_ids, :store_ids

  has_many :dealers
  has_many :stores
  has_many :promotions
  
  def fetchable_fields
    super
  end
end
