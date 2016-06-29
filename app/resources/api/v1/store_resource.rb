# -*- encoding : utf-8 -*-
class Api::V1::StoreResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
  	:dealer_id, :zone_id, :monthly_goal_usd, :monthly_goal_clp,
    :code

  has_one :zone
  has_one :dealer
  has_one :store_type
    

  def fetchable_fields
    super
  end
end
