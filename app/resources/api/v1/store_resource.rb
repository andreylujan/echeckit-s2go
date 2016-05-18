class Api::V1::StoreResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
  	:dealer_id, :zone_id

  has_one :zone
  has_one :dealer
  
  def fetchable_fields
    super
  end
end
