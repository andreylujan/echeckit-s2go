class Api::V1::DealerResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
  	:store_ids, :zone_ids

  has_many :zones
  has_many :stores
  has_many :promotions
  
  def fetchable_fields
    super
  end
end
