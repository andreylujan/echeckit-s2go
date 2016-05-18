class Api::V1::DealerResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
	:zone_ids

  has_many :zones
  has_many :stores
  has_many :promotions
  
  def fetchable_fields
    super
  end

  def self.updatable_fields(context)
    super - [:stores]
  end

  def self.creatable_fields(context)
    super - [:stores]
  end

end
