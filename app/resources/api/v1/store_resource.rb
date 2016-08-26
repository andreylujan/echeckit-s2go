# -*- encoding : utf-8 -*-
class Api::V1::StoreResource < BaseResource
  attributes :name, :contact, :phone_number, :address,
  	:dealer_id, :zone_id, :monthly_goal_usd, :monthly_goal_clp,
    :code

  has_one :zone
  has_one :dealer
  has_one :store_type
  has_one :supervisor
  has_one :instructor
  has_one :promoter

  filters :zone_id, :dealer_id, :promoter_id

  def fetchable_fields
    super
  end
end
