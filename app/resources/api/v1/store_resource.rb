class Api::V1::StoreResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
  	:dealer_id, :zone_id

  has_one :zone
  has_one :dealer
  
  def name
  	if @model.zone.nil? or @model.dealer.nil?
  		return @model.name
  	end
  	@model.name + " - " + @model.dealer.name + " - " + @model.zone.name
  end

  def fetchable_fields
    super
  end
end
