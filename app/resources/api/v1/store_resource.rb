class Api::V1::StoreResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
  	:dealer_ids, :zone_ids

  has_many :zones
  has_many :dealers
  
  def fetchable_fields
    super
  end
end
